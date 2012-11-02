class UI
  attr_reader :game

  def self.start(@player1, @player2)
    DB.create
    puts "How do you want to play today?"
    puts "1 (1 vs 1), 2 (1 vs PC), 3 (1 vs Twitter)"
    case gets.chomp
    when "1"

    when "2"

    when "3"

    else
      puts "Sorry, playing against Queen Elizabeth is not an option!"
      UI.start
    end
    # @player1 = Player.new(create_player("Player 1"))
    #    @player2 = Player.new(create_player("Player 2"))
    #    @player1.save
    #    @player2.save
    @game = Game.new(@player1, @player2)
  end


  def self.game
    @game
  end

  # def self.create_player(player)
  #    puts "Enter username for #{player}"
  #    player_name = gets.chomp.capitalize
  #    puts "Enter your twitter account"
  #    player_twitter = gets.chomp
  #    puts "Enter your password"
  #    player_password = gets.chomp
  #    return { name: player_name, twitter: player_twitter, password: player_password }
  #  end
  #
  #  def self.player_move(current_turn)
  #    puts "#{current_turn}, what column do you want to play in?"
  #    game.next_move(gets.chomp.to_i)
  #  end
  #
  #  def self.congratulations(player)
  #
  #    puts "Congratulations, #{player}. You are a real winner."
  #  end
  #
  #  def self.print_board
  #    game.board.rows.each { |row| p row }
  #  end
  #
  #  def self.board_to_twitter(board_info)
  #    board_format, row_format = "|", ""
  #    board_info.each { |field| field == "" ? (row_format += ".") : (row_format += field) }
  #    game.board.row_num.times do |i|
  #      start_i, end_i = (game.board.col_num*i), (game.board.col_num*(i+1))
  #      board_format += row_format[start_i...end_i] + "|"
  #    end
  #    board_format + ' #dbc-c4'
  #  end
  #
  #  def self.board_from_twitter(move_string)
  #    board_info = move_string.gsub(/\|/, "").split("")
  #    board_info.each { |field| field.gsub!(/\./, "") }
  #    board_info
  #  end


  # def play
  #   until game.board.full? || game.board.check_four_consecutive?
  #     game.next_round == "black" ? current_turn = "#{player1.name}" : current_turn = "#{player2.name}"
  #     if current_turn == "Computer"
  #       game.next_move(rand(7))
  #     else
  #       puts "#{current_turn}, what column do you want to play in?"
  #       game.next_move(gets.chomp)
  #     end
  #   end
  #   puts "The game is over."
  # end

end

