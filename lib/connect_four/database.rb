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