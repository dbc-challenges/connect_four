class Game
  include Database
  attr_reader :player1, :player2, :winner, :board

  def initialize(player1, player2)
    @player1 = player1
    @player2 = player2
    @players = [@player1, @player2]
    @board = Board.new
  end

  def start!
    while !over?
      if board.place(current_player.move)
        toggle_player
      else
        puts "invalid move"
      end
    end
    puts board.winner || "Tie game!"
  end

  def next_move(column)
    round = next_round
    board.place_piece(column, round)
  end

  def next_round
    @board.empty_cells.even? ? "black" : "red"
  end

  def current_player
    @players.first
  end

  def toggle_player
    @players.rotate!
  end

  def save

  end

  def over?
    board.full? || board.four_in_a_row?
  end

  def self.wins_for(player_id)
    db.execute("SELECT COUNT(*) FROM games WHERE winner = ?", player_id).first
  end

  def self.losses_for(player_id)
    db.execute("SELECT COUNT(*) FROM games WHERE player1 = ? OR player2 = ? AND winner != ? AND winner IS NOT NULL", Array.new(3, player_id)).first
  end

  def self.ties_for(player_id)
    db.execute("SELECT COUNT(*) FROM games WHERE player1 = ? OR player2 = ? AND winner IS NULL", Array.new(2, player_id)).first
  end
end
