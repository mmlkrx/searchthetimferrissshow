class FullTextSearch
  def self.find_episodes(query)
    return if query.nil?

    statement = "search"
    sql_query = <<~SQL
      SELECT * FROM episodes
      WHERE document @@ plainto_tsquery($1);
    SQL

    CONN.prepare(statement, sql_query)
    res = CONN.exec_prepared(statement, [query])
    CONN.exec("DEALLOCATE #{statement}")

    res.map do |record|
      Episode.new(
        title: record['title'],
        publishing_date: record['publishing_date'],
        description: record['description']
      )
    end
  end
end
