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
    until board.full? || board.check_four_consecutive?
      next_round == "X" ? current_turn = "#{player1.name}" : current_turn = "#{player2.name}"
      if current_turn == "Computer"
        next_move(rand(7))
      else
        puts "#{current_turn}, what column do you want to play in?"
        next_move(gets.chomp.to_i)
      end
      board.rows.each { |row| p row }
    end
    puts "Congratulations, #{current_turn}. You are a real winner."
    winner = current_turn
  end

  def next_move(column)
    round = next_round
    board.place_piece(column, round) unless column > board.col_num
  end

  def next_round
    @board.empty_cells.even? ? "X" : "O"
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



# def start!
 #     while !over?
 #       if board.place(current_player.move)
 #         toggle_player
 #       else
 #         puts "invalid move"
 #       end
 #     end
 #     puts board.winner || "Tie game!"
 #   end

 # def current_player
 #    @players.first
 #  end
 #
 #  def toggle_player
 #    @players.rotate!
 #  end
 #
 #  def save
 #
 #  end

 # def over?
 #   board.full? || board.four_in_a_row?
 # end
