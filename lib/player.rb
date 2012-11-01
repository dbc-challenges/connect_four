class Player
  attr_reader :name, :twitter, :password, :id

  def initialize(params = {})
    @name = params[:name]
    @twitter = params[:twitter]
    @password = params[:password]
  end


end