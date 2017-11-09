class FullTextSearch
  def self.find_episodes(query)
    [] if query.nil?

    statement = "search"
    sql_query = <<~SQL
      SELECT
        ts_headline(title, keywords, 'HighlightAll=true') AS title,
        publishing_date,
        ts_headline(description, keywords, 'MaxFragments=2,MaxWords=20,MinWords=19') AS description,
        url
      FROM episodes, plainto_tsquery($1) AS keywords
      WHERE document @@ keywords;
    SQL

    CONN.prepare(statement, sql_query)
    res = CONN.exec_prepared(statement, [query])
    CONN.exec("DEALLOCATE #{statement}")

    res.map do |record|
      Episode.new(
        title: record['title'],
        publishing_date: record['publishing_date'],
        description: record['description'],
        url: record['url'],
      )
    end
  end
end
