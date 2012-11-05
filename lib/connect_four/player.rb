class Player
  attr_reader :name, :twitter, :password, :piece

  def initialize(params = {})
    @name = params[:name]
    @twitter = params[:twitter]
    @password = params[:password]
    @piece = params[:piece]
  end

  def save
    values = [name, twitter, password]
    if DB.handler("SELECT * FROM players WHERE twitter = ?", twitter).empty?
      DB.handler("INSERT INTO players (name, twitter, password) VALUES (?, ?, ?);", values)
    end
  end
  
  def id
    @id = DB.handler("SELECT id FROM players WHERE twitter = ?;", twitter).flatten.join.to_i
  end

  def move
    puts "#{name}, what column do you want to play in?"
    gets.chomp.to_i
  end

  def to_s
    name
  end
  
  def wins
    DB.handler("SELECT COUNT(*) FROM games WHERE winner = ?", id).flatten.join
  end

  def losses
    DB.handler("SELECT COUNT(*) FROM games WHERE (player1 = ? OR player2 = ?) AND winner != ? AND winner != 0", Array.new(3, id)).flatten.join
  end

  def ties
    DB.handler("SELECT COUNT(*) FROM games WHERE (player1 = ? OR player2 = ?) AND winner = 0", Array.new(2, id)).flatten.join
  end
end