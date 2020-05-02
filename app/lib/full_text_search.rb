require_relative '../models/episode'

class FullTextSearch
  def self.find_episodes(query)
    [] if query.nil?

    statement = "search"
    sql_query = <<~SQL
      SELECT
        ts_headline(title, keywords, 'HighlightAll=true') AS title,
        ts_headline(transcript, keywords, 'MaxFragments=3,MaxWords=40,MinWords=20') AS transcript,
        show_notes_url
      FROM episodes, websearch_to_tsquery($1) AS keywords
      WHERE transcript_ts @@ keywords
      ORDER BY ts_rank(transcript_ts, keywords) DESC
      LIMIT 10;
    SQL

    CONN.prepare(statement, sql_query)
    res = CONN.exec_prepared(statement, [query])
    CONN.exec("DEALLOCATE #{statement}")

    res.map do |record|
      Episode.new(
        title: record['title'],
        transcript: record['transcript'],
        show_notes_url: record['show_notes_url'],
      )
    end
  end
end
