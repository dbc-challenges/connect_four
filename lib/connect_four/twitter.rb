require 'tweetstream'
#require 'player'
#require 'game'
#require_relative 'ui'

class Tweet

  def initialize
    @random_tag = (('a'..'z').to_a + ('A'..'Z').to_a + (1..9).to_a).shuffle[0..2].join
    @file_path = File.expand_path(File.join(File.dirname(__FILE__) , 'oauth'))#, '..', '..', 'db', name))
    consumer_key_path = File.join(@file_path, "consumer_key.txt")
    consumer_secret_path = File.join(@file_path, "consumer_secret.txt")
    oauth_token_path = File.join(@file_path, "oauth_token.txt")
    oauth_token_secret_path = File.join(@file_path, "oauth_token_secret.txt")

    Twitter.configure { |config| twit_config(config) }
      
    TweetStream.configure do |config|
      twit_config(config)
      config.auth_method = :oauth
    end
    #game_play
  end

  def twit_config(config)
    config.consumer_key       = File.read(consumer_key_path)
    config.consumer_secret    = File.read(consumer_secret_path)
    config.oauth_token        = File.read(oauth_token_path)
    config.oauth_token_secret = File.read(oauth_token_secret_path)   
  end

  def twitter_player
    TweetStream::Client.new.track('#dbc_c4') do |status, client|
      puts "#{status.text}"
      puts "Game on! #dbc_c4" if "#{status.text}" == "Who wants to get demolished?"
      client.stop
      #Twitter.update("@#{status.user[:screen_name]} Game on! #dbc_c4") if "#{status.text}" == "Who wants to get demolished?"
      return TwitterPlayer.new({name: status.user[:name], twitter: status.user[:screen_name], piece: 'X'})
    end
  end

  # def twitter_move_relay
  #   TweetStream::Client.new.track("#{player1.twitter}") do |status, client|
  #     puts "#{status.text}"
  #     #look for incoming move
  #     #Twitter.update("@#{status.user[:screen_name]} Game on! #dbc_c4") if "#{status.text}" == "Who wants to get demolished?"
  #     client.stop
  #     return "#{status.text}"
  #   end
  # end

  def tweet_board(tweet, message)
    puts "#{player1.twitter} #{tweet} #{message} #{random_tag}"
    #Twitter.update("#{player1.twitter} #{tweet} #{message}")
  end





end
