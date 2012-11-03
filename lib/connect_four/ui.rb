class UI
  attr_reader :game

  def self.start(player1, player2)
    DB.create
    puts "How do you want to play today? Pick a number"
    puts "1 - (1 vs 1), 2 - (1 vs PC), 3 - (1 vs Twitter)"
    case gets.chomp
    when "1"
      puts "Good choice!"
      UI.create_1vs1_player
    when "2"
      puts "How dare you! I will demolish you!"
      UI.create_1vsPC_player
    when "3"
      puts "I will send out the message pigeon!"
      tweet = Tweet.new
      UI.create_1vsTwitter_player
    else
      puts "Sorry, playing against Queen Elizabeth is not an option!"
      UI.start
    end
    @game = Game.new(@player1, @player2)
  end

  def self.game
    @game
  end


  def self.create_1vs1_player
    puts "Who wants to be first?"
    @player1 = Player.new(create_player("Player 1"))
    @player1.save
    puts "Last but not least:"
    @player2 = Player.new(create_player("Player 2"))
    @player2.save
  end

  def self.create_1vsPC_player
    puts "Whose name should I write on you gravestone?"
    @player1 = computer_player
    @player2 = Player.new(create_player("the dead guy"))
    @player2.save
  end

  def self.create_1vsTwitter_player
    @player1 = tweet.track_new_game
    @player2 = Player.new(create_player("Player"))
    @player2.save
  end


  def self.create_player(player)
     puts "Enter username for #{player}"
     player_name = gets.chomp.capitalize
     puts "Enter your twitter account"
     player_twitter = gets.chomp
     puts "Enter your password"
     player_password = gets.chomp
     return { name: player_name, twitter: player_twitter, password: player_password }
   end

   def self.player_move(current_turn)
     puts "#{current_turn}, what column do you want to play in?"
     game.next_move(gets.chomp.to_i)
   end

   def self.congratulations(player)
     if player == nil
       puts "Draw."
     else
       puts "Congratulations #{player}. You are a real winner."
     end
   end

   def self.print_board
     game.board.rows.each { |row| p row }
   end

   def self.board_to_twitter(board_info)
     board_format, row_format = "|", ""
     board_info.each { |field| field == "" ? (row_format += ".") : (row_format += field) }
     game.board.row_num.times do |i|
       start_i, end_i = (game.board.col_num*i), (game.board.col_num*(i+1))
       board_format += row_format[start_i...end_i] + "|"
     end
     board_format
   end

   def self.board_from_twitter(move_string)
     board_info = move_string.gsub(/\|/, "").split("")
     board_info.each { |field| field.gsub!(/\./, "") }
     board_info
   end


    # def play
    #    until game.board.full? || game.board.check_four_consecutive?
    #      game.next_round == "black" ? current_turn = "#{player1.name}" : current_turn = "#{player2.name}"
    #      if current_turn == "Computer"
    #        game.next_move(rand(7))
    #      else
    #        puts "#{current_turn}, what column do you want to play in?"
    #        game.next_move(gets.chomp)
    #      end
    #    end
    #    puts "The game is over."
    #  end
    #
end

