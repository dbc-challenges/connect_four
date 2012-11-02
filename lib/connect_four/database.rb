require 'sqlite3'

class DB
  def self.create(name = "connectfour.db")
    file_path = File.expand_path(File.join(File.dirname(__FILE__), '..', '..', 'db', name))

    unless File.exists?(file_path)
      #system("touch #{name}")
      system("sqlite3 #{file_path} < ./db/schema.sql")
    end

    SQLite3::Database.new(file_path)
  end

  def self.handler(string, *values)
    db = SQLite3::Database.new("connectfour.db")
    db.execute(string, *values.flatten)
    db.close
  end

  # def self.db
  #   @db ||= find_or_create
  # end
  #
  # def self.find_or_create
  #   name = "connectfour.db"
  #   system("sqlite3 #{name} < ./db/schema.sql")
  #   SQLite3::Database.new(name)
  # end
  #
  # def self.execute(query, *args)
  #   db.execute(query, args)
  # end
end

module Database
  def db
    @db ||= find_or_create
  end

  def find_or_create
    name = "connectfour.db"
    db_path = File.expand_path(File.join(File.dirname(__FILE__), '..', '..', 'db'))
    p db_path
    schema_path = File.join(db_path, 'schema.sql')
    database_path = File.join(db_path, name)

    system("sqlite3 #{file_path} < #{schema_path}")
    SQLite3::Database.new(database_path)
  end
end


