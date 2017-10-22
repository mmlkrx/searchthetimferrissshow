class Config
  class Db
    def self.host
      ENV['DB_HOST'] || database_yaml['host']
    end

    def self.port
      ENV['DB_PORT'] || database_yaml['port']
    end

    def self.user
      ENV['DB_USER'] || database_yaml['user']
    end

    def self.name
      ENV['DB_NAME'] || database_yaml['name']
    end

    private

    def self.database_yaml
      @parsed ||= YAML.load(File.read('db/database.yml'))
    end
  end
end
