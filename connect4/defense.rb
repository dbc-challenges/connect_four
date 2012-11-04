require_relative 'board'

class Defense
  attr_reader :board, :positions_ratings

  def initialize
    #@board = Board.new
    @positions_ratings = { 1=>0, 2=>0, 3=>0, 4=>0, 5=>0, 6=>0, 7=>0}
  end

  def available_moves
    @available_moves = []
    first_row = [35, 36, 37, 38, 39, 40, 41]
    first_row.each do |position|
      until UI.game.board.cells[position].empty?
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
    end
    positions_ratings
  end

  def cell_rating_left(position)
    left_cell = UI.game.board.cells[position-1]
    unless [35, 28, 21, 14, 7, 0].include?(position)
      if left_cell == "red"
        positions_ratings[(position%7)+1] += 2
        # cell_rating_left2(position) unless [36, 29, 22, 15, 8, 1].include?(position)
      else
        positions_ratings[position%7+1] ||= 0
      end
    end
  end

  def cell_rating_left2(position)
    left_cell2 = UI.game.board.cells[position-2]
    if left_cell2 == "red"
      positions_ratings[position%7+1] += 4
      cell_rating_left_3(position) unless [37, 30, 23, 16, 9, 2].include?(position)
    end
  end

  def cell_rating_left_3(position)
    left_cell3 = UI.game.board.cells[position-3]
    if left_cell3 == "red"
      positions_ratings[position%7+1] += 8
    end
  end

  def cell_rating_right(position)
    if position % 7 < 6
      right_cell = UI.game.board.cells[position+1]
      if right_cell == "red"
        positions_ratings[position%7+1] = 2
    else
      positions_ratings[position%7+1] ||= 0
      end
    end
  end

  def cell_rating_bottom(position)
    unless [35, 36, 37, 38, 39, 40, 41].include?(position)
      bottom_cell = UI.game.board.cells[position+7]
      if bottom_cell == "red"
        positions_ratings[position%7+1] = 2
    else
      positions_ratings[position%7+1] ||= 0
      end
    end
  end

  def move
    rate_all_cells
    play_column = positions_ratings.max_by {|k, v| v}.first.to_i
    #board.place_piece(play_column, "black")
    positions_ratings.clear
    return play_column
  end

end