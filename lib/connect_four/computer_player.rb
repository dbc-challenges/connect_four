class ComputerPlayer

  attr_reader :name, :twitter, :password, :id, :piece

  def initialize(params = {})
    @name = params[:name]
    # @twitter = params[:twitter]
    # @password = params[:password]
    @piece = params[:piece]
  end

  def move
    rand(7)
  end
end