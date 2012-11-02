class Player
  #include Database
  attr_reader :name, :twitter, :password, :id

  def initialize(params = {})
    @name = params[:name]
    @twitter = params[:twitter]
    @password = params[:password]
  end

  def save
    values = [name, twitter, password]
    if db.execute("SELECT * FROM players WHERE twitter = ?", twitter).empty?
      db.execute("INSERT INTO players (name, twitter, password) VALUES (?, ?, ?);", values)
    end
  end


end