CONN = PG::Connection.new(
  host: 'pgserver',
  port: 5432,
  dbname: 'stfs',
  user: 'stfs'
)
