require 'sqlite3'

class DB
  attr_reader :file_path
  def self.create(name = "connectfour.db")
    @file_path = File.expand_path(File.join(File.dirname(__FILE__), '..', '..', 'db', name))

    unless File.exists?(@file_path)
      system("sqlite3 #{@file_path} < ./db/schema.sql")
    end

    SQLite3::Database.new(@file_path)
  end

  def self.handler(string, *values)
    db = SQLite3::Database.new(@file_path)
    result = db.execute(string, *values.flatten)
    db.close
    result
  end

end

module Database
  # def db
  #   @db ||= find_or_create
  # end
  #
  # def find_or_create
  #   name = "connectfour.db"
  #   db_path = File.expand_path(File.join(File.dirname(__FILE__), '..', '..', 'db'))
  #   p db_path
  #   schema_path = File.join(db_path, 'schema.sql')
  #   database_path = File.join(db_path, name)
  #
  #   system("sqlite3 #{db_path} < #{schema_path}")
  #   SQLite3::Database.new(database_path)
  # end
end


