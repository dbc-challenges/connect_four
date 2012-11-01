class Player
  attr_reader :color

  #players are initialized with a color, color '1' or color '2'
  def initialize(color)
    @color = color
  end

  def next_move
    column = gets.chomp.to_i
  end
end