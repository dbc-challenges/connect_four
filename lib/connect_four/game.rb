class Game
  include Database
  attr_reader :player1, :player2, :winner, :board

  def initialize(player1, player2)
    @player1 = player1
    @player2 = player2
    @players = [@player1, @player2]
    @board = Board.new
  end

  def play
    until over?
      board.place_piece(current_player.move, current_player.piece)
      toggle_player unless over?
      UI.board_display unless over?
    end
    if board.full?
      winner = nil
    else
      winner = current_player
    end
    UI.congratulations(winner)
  end

  def toggle_player
    @players.rotate!
  end

  def current_player
    @players.first
  end

  def over?
    board.full? || board.check_four_consecutive?
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

