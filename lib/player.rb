class Player
  attr_reader :color

  def initialize(color)
    @color = color
  end

  def next_move
    column = gets.chomp.to_i
  end
end