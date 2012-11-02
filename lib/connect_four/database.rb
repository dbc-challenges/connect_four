require 'sqlite3'

class DB

  def self.create(name = "connectfour.db")

    unless File.exists?(name)
      system("touch #{name}")
      system("sqlite3 #{name} < ./db/schema.sql")
    end

    return SQLite3::Database.new(name)
  end

  def self.handler(string, *values)
    db = SQLite3::Database.new("connectfour.db")
    db.execute(string, *values.flatten)
    db.close
  end
end


