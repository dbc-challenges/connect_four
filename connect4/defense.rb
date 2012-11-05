require_relative 'board'

class Defense
  attr_reader :board, :positions_ratings

  def initialize
    @board = Board.new
    @positions_ratings = { 1=>0, 2=>0, 3=>0, 4=>0, 5=>0, 6=>0, 7=>0}
  end

  def available_moves
    @available_moves = []
    first_row = [35, 36, 37, 38, 39, 40, 41]
    first_row.each do |position|
      until board.cells[position].empty?
        position -= board.col_num
      end
      @available_moves << position
    end
    return @available_moves
  end

  def rate_all_cells
    available_moves.each do |move|
      cell_rating_left(move)
      cell_rating_right(move)
      cell_rating_bottom(move)
    end
    positions_ratings
  end

  def cell_rating_left(position)
    left_cell = board.cells[position-1]
    unless [35, 28, 21, 14, 7, 0].include?(position)
      if left_cell == "red"
        positions_ratings[(position%7)+1] += 2
        cell_rating_left2(position) unless [36, 29, 22, 15, 8, 1].include?(position)
      end
    end
    positions_ratings[position%7+1]
  end

  def cell_rating_left2(position)
    left_cell2 = board.cells[position-2]
    if left_cell2 == "red"
      positions_ratings[position%7+1] += 4
      cell_rating_left3(position) unless [37, 30, 23, 16, 9, 2].include?(position)
    end
  end

  def cell_rating_left3(position)
    left_cell3 = board.cells[position-3]
    if left_cell3 == "red"
      positions_ratings[position%7+1] += 8
    end
  end

  def cell_rating_right(position)
    right_cell = board.cells[position+1]
    unless [41, 34, 27, 20, 13, 6].include?(position)
      if right_cell == "red"
        positions_ratings[position%7+1] += 2
        cell_rating_right2(position) unless [40, 33, 26, 19, 12, 5].include?(position)
      end
    end
    positions_ratings[position%7+1]
  end

  def cell_rating_right2(position)
    right_cell2 = board.cells[position+2]
    if right_cell2 == "red"
      positions_ratings[position%7+1] += 4
      cell_rating_right3(position) unless [39, 32, 25, 18, 11, 4].include?(position)
    end
  end

  def cell_rating_right3(position)
    right_cell3 = board.cells[position+3]
    if right_cell3 == "red"
      positions_ratings[position%7+1] += 8
    end
  end

  def cell_rating_bottom(position)
    unless [35, 36, 37, 38, 39, 40, 41].include?(position)
      bottom_cell = board.cells[position+7]
      if bottom_cell == "red"
        positions_ratings[position%7+1] += 2
        cell_rating_bottom2(position) unless [28, 29, 30, 31, 32, 33, 34].include?(position)
      end
    end
    positions_ratings[position%7+1]
  end

  def cell_rating_bottom2(position)
    bottom_cell2 = board.cells[position+14]
    if bottom_cell2 == "red"
      positions_ratings[position%7+1] += 4
      cell_rating_bottom3(position) unless [22, 23, 24, 25, 26, 27].include?(position)
    end
  end

  def cell_rating_bottom3(position)
    bottom_cell3 = board.cells[position+21]
    if bottom_cell3 == "red"
      positions_ratings[position%7+1] += 8
    end
  end

  def move
    rate_all_cells
    play_column = positions_ratings.max_by {|k, v| v}.first.to_i
    board.place_piece(play_column, "black")
    positions_ratings.each {|k,v| positions_ratings[k] = 0}
  end

end