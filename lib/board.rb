class Board
  attr_reader :col_num, :row_num, :cells

  def initialize(col_num = 7, row_num = 6)
    @cells = Array.new(col_num * row_num, "")
        #
    @col_num = col_num
    @row_num = row_num
  end

  def empty?
    cells.all? { |cell| cell.empty? }
  end

  def place_piece(column, piece)
    position = (col_num * (row_num - 1)) + (column - 1)
    until cells[position].empty?
      position -= 7
    end
    cells[position] = piece
  end
  1

  def full?
    cells.all? {|cell| cell != "" }
  end

end

