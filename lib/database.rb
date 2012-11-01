require 'sqlite3'

class DB

  def self.create(name = "connectfour.db")

    unless File.exists?(name)
      system("touch #{name}")
      system("sqlite3 #{name} < schema.sql")
    end

    return SQLite3::Database.new(name)
  end
end


