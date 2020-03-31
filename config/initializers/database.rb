require 'pg'

CONN = PG::Connection.new(
  host: Config::Db.host,
  port: Config::Db.port,
  dbname: Config::Db.name,
  user: Config::Db.user
)
