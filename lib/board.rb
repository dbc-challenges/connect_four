class Board
  attr_reader :last_drop_column, :board

  def initialize(board = nil)
    if board.nil?
      @board = Array.new(7) { Array.new(6) }
    else
      @board = board
    end

    @last_drop_column = nil
    @last_drop_row = nil
    @last_drop_color = nil
  end

  def drop_disc!(column, color)
    return false if column > 7 || column < 1
    @board[column-1].each_with_index do |cell, index|
      if cell.nil?
        @board[column-1][index] = color
        @last_drop_column = column - 1
        @last_drop_row = index
        @last_drop_color = color
        return true
      end
    end
    false
  end

  def [](column)
    self.board[column]
  end

  def full?
    @board.each do |column|
      column.each do |cell|
        return false if cell.nil?
      end
    end
    true
  end

  def color_of_connect_four
    if @last_drop_column.nil? || @last_drop_color.nil? || @last_drop_row.nil?
      return nil
    end
    return @last_drop_color if four_in_column || four_in_row ||four_in_upward_diagonal || four_in_downward_diagonal
    nil
  end

  def column_full?(column)
    !@board[column][5].nil?
  end

  def to_s
    board_string = ""
    5.downto(0) do |row|
      7.times do |column|
        board[column][row].nil? ? piece = " " : piece = board[column][row]
        board_string << "[ #{piece} ]"
      end
      board_string << "\n"
    end
    board_string
  end

  def self.from_string(string)
    board_of_rows = []
    string[1..-1].split('|').each do |row|
      board_of_rows << row.split('').map do |cell|
        case cell
        when nil then nil
        when "X" then 1
        when "O" then 2
        end
      end
    end
    Board.new(board_of_rows.reverse.transpose)
  end

  private

  def four_in_column
    return false if @last_drop_row < 3

    count = 0
    @board[@last_drop_column].each do |cell|
      break if cell.nil?
      cell == @last_drop_color ? count += 1 : count = 0
    end
    count > 3
  end

  def four_in_row
    count = 0
    @board.each do |column|
      break if count > 3
      column[@last_drop_row] == @last_drop_color ? count += 1 : count = 0
    end
    count > 3
  end

  def four_in_upward_diagonal
    @last_drop_column > @last_drop_row ? min_coordinate = @last_drop_row : min_coordinate = @last_drop_column
    base_row = @last_drop_row - min_coordinate
    base_column = @last_drop_column - min_coordinate


    count = 0
    until base_row > 5 || base_column > 6
      break if count > 3
      @board[base_column][base_row] == @last_drop_color ? count += 1 : count = 0
      base_column += 1
      base_row += 1
    end
    count > 3
  end

  def four_in_downward_diagonal
    (6-@last_drop_column) > @last_drop_row ? min_coordinate = @last_drop_row : min_coordinate = (6-@last_drop_column)
    base_row = @last_drop_row - min_coordinate
    base_column = @last_drop_column + min_coordinate

    count = 0
    until base_row > 5 || base_column < 0
      break if count > 3
      @board[base_column][base_row] == @last_drop_color ? count += 1 : count = 0
      base_column -= 1
      base_row += 1
    end
    count > 3
  end

end