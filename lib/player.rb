class Player
  attr_reader :color, :name

  #players are initialized with a color, color '1' or color '2'
  def initialize(name, color)
    @name = name
    @color = color
  end

  def next_move
    column = gets.chomp.to_i
  end

  def to_s
    "Name: #{name}   Color: #{color}"
  end

end