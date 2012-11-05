class Board
  attr_reader :col_num, :row_num
  attr_accessor :cells

  def initialize(col_num = 7, row_num = 6)
    @cells = Array.new(col_num * row_num, "")
    @col_num = col_num
    @row_num = row_num
  end

  def empty?
    cells.all? { |cell| cell.empty? }
  end

  def empty_cells
    cells.select {|cell| cell == "" }.size
  end

  def place_piece(column, piece)
    position = (col_num * (row_num - 1)) + (column - 1)
    until cells[position].empty?
      position -= col_num
    end
    cells[position] = piece
  end

  def full?
    cells.all? {|cell| cell != "" }
  end

  def rows
    cells.each_slice(col_num).collect { |row| row }
  end

  def columns
    columns_array = Array.new(col_num) { Array.new([]) }
    cells.each_with_index do |cell, i|
      columns_array[i % col_num] << cell
    end
    columns_array
  end

  def get_start_indexes_to_right(win_no)
    container = []
    (col_num - (win_no-1)).times do |i|
      container << i
    end
    (row_num - (win_no-1)).times do |i|
        container << i*col_num unless i == 0
    end
    container
  end

  def get_start_indexes_to_left(win_no)
    container = []
    (col_num - win_no+1).times do |i|
      container << i + (win_no-1)
    end
    (row_num - (win_no-1)).times do |i|
        container << (i*col_num + col_num-1) unless i == 0
    end
    container
  end

  def row_index_number(index)
    (index / col_num).floor
  end

  def column_index_number(index)
    index % col_num
  end

  def diagonal_indexes_to_right
     start_indexes = get_start_indexes_to_right(4)
     leap = col_num + 1
     start_indexes.map do |index|
       diagonal = []
       while true
         diagonal << index
         index += leap
         row, column = row_index_number(index), column_index_number(index)
         break if row == row_num || column == 0
       end
       diagonal
     end
   end

  def diagonal_indexes_to_left
     start_indexes = get_start_indexes_to_left(4)
     leap = col_num - 1
     start_indexes.map do |index|
       diagonal = []
       while true
         diagonal << index
         index += leap
         row, column = row_index_number(index), column_index_number(index)
         break if row == row_num || column == col_num-1
       end
       diagonal
     end
   end

  # def diagonal_indexes(direction)
  #   start_indexes = get_start_indexes_to_left(4)
  #   leap = col_num + 1 if direction == "to_right"
  #   leap = col_num - 1 if direction == "to_left"
  #   start_indexes.map do |index|
  #     diagonal = []
  #     while true
  #       diagonal << index
  #       index += leap
  #       row, column = row_index_number(index), column_index_number(index)
  #       break if (row == row_num || column == 0) && direction == "to_right"
  #       break if (row == row_num || column == col_num-1) && direction == "to_left"
  #     end
  #     diagonal
  #   end
  # end

  def diagonals
    (diagonal_indexes_to_right + diagonal_indexes_to_left).map {|diagonal| diagonal.map { |i| i = cells[i]}}
    # (diagonal_indexes("to_right") + diagonal_indexes("to_left")).map {|diagonal| diagonal.map { |i| i = cells[i]}}
  end


  def check_four_consecutive?
    # (columns + rows + diagonals).any? { |group| group.four_consecutive? }
    (columns + rows + diagonals).any? { |lines| four_consecutive?(lines) }
  end

  def four_consecutive?(line)
    line.each_cons(4) do |element|
      return true if (element.uniq.size == 1 && element.uniq[0] != "")
    end
    false
  end

end