require 'tweetstream'
#require 'player'
#require 'game'

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
    TweetStream::Client.new.track('bieber') do |status|
      Twitter.update("@#{status.user[:screen_name]} Game on! #dbc_c4") if "#{status.text}" == "Who wants to get demolished?"
      player1 = Player.new(status.user[:name], status.user[:screen_name], "password")
      return player1
    end
  end

  def game_play
    player2 = UI.create_player
    player1 = track_new_game
    UI.start(player1, player2)
    TweetStream::Client.new.track(player1) do |status|
      UI.game.board.cells = UI.board_from_twitter(status.text)
      UI.player_move(UI.player2.name)
      tweet_board(UI.board_to_twitter(UI.game.board.cells))
    end
  end

  def tweet_board(tweet, message = '#dbc-c4')

    puts "#{player1.twitter} #{tweet} #{message}"
    #Twitter.update("#{player1.twitter} #{tweet} #dbc_c4")
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

  #when you receive a tweet, create a player2 and respond with game on.

  #initiate a game with two players

  #start listening for the other player's tweets and look for first move.

  #when you receive the first move tweet plug it into game and prompt player for next move.

  #format next move and tweet

end
