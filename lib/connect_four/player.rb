class Player
 # include Database

  attr_reader :name, :twitter, :password, :id

  def initialize(params = {})
    @name = params[:name]
    @twitter = params[:twitter]
    @password = params[:password]
  end

  def save
    values = [name, twitter, password]
    if DB.handler("SELECT * FROM players WHERE twitter = ?", twitter).empty?
      DB.handler("INSERT INTO players (name, twitter, password) VALUES (?, ?, ?);", values)
    end
  end


end