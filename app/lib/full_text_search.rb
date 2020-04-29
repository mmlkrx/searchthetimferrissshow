require_relative '../models/episode'

class FullTextSearch
  def self.find_episodes(query)
    [] if query.nil?

    statement = "search"
    sql_query = <<~SQL
      SELECT
        ts_headline(title, keywords, 'HighlightAll=true') AS title,
        ts_headline(transcript, keywords, 'MaxFragments=3,MaxWords=40,MinWords=20') AS transcript,
        url
      FROM episodes, plainto_tsquery($1) AS keywords
      WHERE document @@ keywords
      ORDER BY ts_rank(document, keywords) DESC;
    SQL

    CONN.prepare(statement, sql_query)
    res = CONN.exec_prepared(statement, [query])
    CONN.exec("DEALLOCATE #{statement}")

    res.map do |record|
      Episode.new(
        title: record['title'],
        transcript: record['transcript'],
        url: record['url'],
      )
    end
  end
end
