require 'io/console'
require './database.rb'
class UI
  attr_reader :game, :tweet

  def self.start(start_message = "Welcome to Connect Four! Pick a number")
    DB.create
    puts "=" * 100
    puts start_message
    puts "1 - (1 vs 1), 2 - (1 vs PC), 3 - (1 vs Twitter), 4 - (PC vs Twitter), "
    puts "s - (Statistic), r - (repeat game), q - (quit)"
    puts "=" * 100
    choices(gets.chomp)
    puts "=" * 50
    puts "THE GAME IS ON:"
    @game = Game.new(@player1, @player2)
    @game.play
  end

  def self.game
    @game
  end
  
  def self.choices(user_input)
    case user_input
    when "1"
      puts "Good choice!"
      create_1vs1_player
    when "2"
      puts "How dare you! I will demolish you!"
      create_1vsPC_player
    when "3"
      puts "I will send out the message pigeon!"
      create_1vsTwitter_player
    when "4"
      puts "Game on!"
      create_PCvsTwitter_player
    when "s"
      show_user_statistic
   when "r"
     return
   when "q"
     puts "=" * 100
      puts "Auf Wiedersehen!"
      exit
    else
      start("Sorry, playing against Queen Elizabeth is not an option! Try again.")
    end
  end

  def self.create_1vs1_player
    @player1 = Player.new(create_player("Player X").merge(:piece => 'X'))
    @player1.save
    @player2 = Player.new(create_player("Player O").merge(:piece => 'O'))
    @player2.save
  end

  def self.create_1vsPC_player
    @player1 = ComputerPlayer.new({name: "MCP", piece: 'X'})
    @player2 = Player.new(create_player("Player O").merge(:piece => 'O'))
    @player2.save
  end

  def self.create_1vsTwitter_player
    @player2 = Player.new(create_player("Player O").merge(:piece => 'O'))
    @player1 = TwitterPlayer.from_twitter
  end
  
  def self.create_PCvsTwitter_player
    @player2 = ComputerPlayer.new({name: "MCP", piece: 'O'})
    @player1 = TwitterPlayer.from_twitter
  end
  
  def self.show_user_statistic
    @player = Player.new(create_player("Player"))
    puts "STATISTIC for #{@player}"
    puts "=" * 50
    puts "WINS: #{@player.wins}"
    puts "LOSSES: #{@player.losses}"
    puts "TIES: #{@player.ties}"
    start("What do you want to do now?")
  end
  
  def self.board_display
    if (game.current_player == @player1) && (@player1.class == TwitterPlayer)
      puts game.board.to_s
      tweet_board(game.board.to_s, twitter_tag)
    else
      print_board
    end
  end

  def self.tweet_board(tweet, message)
    puts "@#{@player1.twitter} #{tweet} #{message} #{@player1.random_tag}"
    Twitter.update("@#{@player1.twitter} #{tweet} #{message} #{@player1.random_tag}")
  end

  def self.create_player(player)
    player_name = get_player_name(player)
    { name: player_name, 
      twitter: unique_twitter_account(player_name, player), 
      password: secure_password 
    }
  end
  
  def self.get_player_name(player)
    puts "=" * 50
    puts "Enter username for #{player}"
    gets.chomp.capitalize
  end
  
  def self.unique_twitter_account(player_name,player)
    puts "Enter your twitter account"
    twitter = gets.chomp
    if valid_twitter?(player_name, twitter)
      return twitter
    else
      puts "Invalid player name or twitter account"
      create_player(player)
    end
  end
  
  def self.valid_twitter?(player_name, twitter)
    DB.check_twitter(player_name, twitter)
  end
  
  def self.secure_password
    puts "Enter your password"        
    pwd = STDIN.noecho {|i| i.gets}.chomp
    valid_password?(pwd)
  end
  
  def self.valid_password?(pwd)
    unless pwd.empty? # && pwd.length > 6
      return pwd
    else
      puts "Password too short"
      secure_password
    end
  end

  def self.twitter_tag
    if game.board.full? 
      message = "Draw game. Play again? #dbc_c4"
    elsif game.board.check_four_consecutive? 
      game.board.empty_cells.even? ? message = "I win! Good game. #dbc_c4" : message = "You win. #dbc_c4"
    else
      message = '#dbc_c4'
    end
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
    board_array = game.board.to_s.split('|')
    board_array.each do |row|
      puts "|#{row}|" unless row == ""
    end
  end

end