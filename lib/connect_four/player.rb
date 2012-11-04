class Player
 # include Database

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
    @id = DB.handler("SELECT id FROM players WHERE twitter = #{@twitter}")
  end

  def move
    puts "#{name}, what column do you want to play in?"
    gets.chomp.to_i
  end

  def to_s
    name
  end
end