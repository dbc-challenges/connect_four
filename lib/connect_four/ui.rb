class UI

  attr_reader :game, :tweet

  def self.start
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
    @game.play
  end

  def self.game
    @game
  end

  def self.create_1vs1_player
    puts "Who wants to be first?"
    @player1 = Player.new(create_player("Player 1").merge(:piece => 'X'))
    @player1.save
    puts "Last but not least:"
    @player2 = Player.new(create_player("Player 2").merge(:piece => 'O'))
    @player2.save
  end

  def self.create_1vsPC_player
    @player1 = ComputerPlayer.new({name: "MCP", piece: 'X'})
    @player2 = Player.new(create_player("Player 2").merge(:piece => 'O'))
    @player2.save
  end

  def self.create_1vsTwitter_player
    #@tweet = Tweet.new
    @player2 = ComputerPlayer.new({name: "MCP", piece: 'O'})
    #@player2 = Player.new(create_player("Player 2").merge(:piece => 'O'))
    @player1 = TwitterPlayer.from_twitter
    
  end

  def self.board_display
    if game.current_player == @player1
      if @player1.class == TwitterPlayer
        puts game.board.to_s
        tweet_board(game.board.to_s, twitter_tag)
      else 
        print_board
      end
    else
      print_board
    end
  end

  def self.tweet_board(tweet, message)
    puts "@#{@player1.twitter} #{tweet} #{message} #{@player1.random_tag}"
    Twitter.update("@#{@player1.twitter} #{tweet} #{message} #{@player1.random_tag}")
  end

  def self.create_player(player)
    puts "Enter username for #{player}"
    player_name = gets.chomp.capitalize
    puts "Enter your twitter account"
    player_twitter = gets.chomp
    puts "Enter your password"
    player_password = gets.chomp
    { name: player_name, twitter: player_twitter, password: player_password }
  end

  def self.twitter_tag
    if game.board.full? # tie
      message = "Draw game. Play again? #dbc_c4"
    elsif game.board.check_four_consecutive? #winner
      if game.board.empty_cells.even?
        message = "I win! Good game. #dbc_c4"
      else
        message = "You win. #dbc_c4"
      end
    else
      message = '#dbc_c4'
    end
    return message
  end

  def self.congratulations(player)
    if @player1.class == TwitterPlayer
      tag = twitter_tag
      tweet_board(game.board.to_s, tag)
    else
      print_board
      if player == nil
        puts "Draw."
      elsif player.name == "MCP"
        puts "You lose, loser."
      else
        puts "Congratulations #{player.name}. You are a real winner."
      end
    end
  end

  def self.print_board
    #puts game.board.to_s #needs vertical formatting
    board_array = game.board.to_s.split('|')
    #p board_array
    board_array.each do |row|
      puts "|#{row}|" unless row == ""
    end
    #game.board.rows.each { |row| p row }
  end

  # def self.board_to_twitter(board_info)
  #   board_format, row_format = "|", ""
  #   board_info.each { |field| field == "" ? (row_format += ".") : (row_format += field) }
  #   game.board.row_num.times do |i|
  #     start_i, end_i = (game.board.col_num*i), (game.board.col_num*(i+1))
  #     board_format += row_format[start_i...end_i] + "|"
  #   end
  #   board_format
  # end

  # def self.board_from_twitter(move_string)
  #   board_info = move_string.gsub(/\|/, "").split("")
  #   board_info.each { |field| field.gsub!(/\./, "") }
  #   board_info
  # end



end