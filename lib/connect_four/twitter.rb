require 'tweetstream'
#require 'player'
#require 'game'
require_relative 'ui'

class Tweet

  def initialize
    @file_path = File.expand_path(File.join(File.dirname(__FILE__) , 'oauth'))#, '..', '..', 'db', name))
    consumer_key_path = File.join(@file_path, "consumer_key.txt")
    consumer_secret_path = File.join(@file_path, "consumer_secret.txt")
    oauth_token_path = File.join(@file_path, "oauth_token.txt")
    oauth_token_secret_path = File.join(@file_path, "oauth_token_secret.txt")

    Twitter.configure do |config|
      config.consumer_key = File.read(consumer_key_path)
      config.consumer_secret = File.read(consumer_secret_path)
      config.oauth_token = File.read(oauth_token_path)
      config.oauth_token_secret = File.read(oauth_token_secret_path)
    end

    TweetStream.configure do |config|
      config.consumer_key       = File.read(consumer_key_path)
      config.consumer_secret    = File.read(consumer_secret_path)
      config.oauth_token        = File.read(oauth_token_path)
      config.oauth_token_secret = File.read(oauth_token_secret_path)
      config.auth_method        = :oauth
    end
    game_play
  end

  def track_new_game
    TweetStream::Client.new.track('#dbc_c4') do |status|
      puts "#{status.text}"
      Twitter.update("@#{status.user[:screen_name]} Game on! #dbc_c4") if "#{status.text}" == "Who wants to get demolished?"
      player1 = Player.new(status.user[:name], status.user[:screen_name], "password")
      return player1
    end
  end

  def game_play
    player2 = UI.create_player("Player 2")#get manual user info and create local user
    player1 = track_new_game#create player from twitter
    UI.start(player1, player2)#create game instance

    TweetStream::Client.new.track(player1) do |status|
      UI.game.board.cells = UI.board_from_twitter(status.text)
      UI.player_move(UI.player2.name)
      #test board
      if UI.game.board.full? # tie
        message = "Draw game. Play again? #dbc_c4"
      elsif UI.game.board.check_four_consecutive? #winner
        puts "Somebody won."
        #message = "I win! Good game. #dbc_c4"
        #message = "You win. #dbc_c4"
      else
        message = '#dbc_c4'
      end
      tweet_board(UI.board_to_twitter(UI.game.board.cells, message))
    end
  end

  def tweet_board(tweet, message)
    puts "#{player1.twitter} #{tweet} #{message}"
    #Twitter.update("#{player1.twitter} #{tweet} #{message}")
  end

  # def board_to_twitter(board_info)
  #   board_format, row_format = "|", ""
  #   board_info.each { |field| field == "" ? (row_format += ".") : (row_format += field) }
  #   row_num.times do |i|
  #     start_i, end_i = (col_num*i), (col_num*(i+1))
  #     board_format += row_format[start_i...end_i] + "|"
  #   end
  #   board_format
  # end

  # def board_from_twitter(move_string)
  #   board_info = move_string.gsub(/\|/, "").split("")
  #   board_info.each { |field| field.gsub!(/\./, "") }
  #   board_info
  # end


end

Tweet.new