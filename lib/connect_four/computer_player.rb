class ComputerPlayer

  attr_reader :name, :twitter, :password, :id, :piece

  def initialize(params = {})
    @name = params[:name]
    @piece = params[:piece]
  end

  def move
    rand(7) + 1
  end
end