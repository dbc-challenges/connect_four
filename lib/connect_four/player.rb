class Player
  attr_reader :name, :twitter, :password, :id

  def initialize(params = {})
    @name = params[:name]
    @twitter = params[:twitter]
    @password = params[:password]
  end

  def insert_to_db
    values = [name, twitter, password]
    if DB.handler("select * from players where twitter = #{twitter}").nil?
      DB.handler("INSERT INTO players (name, twitter, password) VALUES (?, ?, ?);", values)
    end
  end


end