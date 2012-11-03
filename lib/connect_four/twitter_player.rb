require 'tweetstream'

class TwitterPlayer
attr_reader :name, :twitter, :piece, :random_tag

  def initialize(options={})
  	@name = options[:name]
    @twitter = options[:twitter]
    @piece = options[:piece]
  end

  def self.from_twitter
    @random_tag = (('a'..'z').to_a + ('A'..'Z').to_a + (1..9).to_a).shuffle[0..2].join
    @file_path = File.expand_path(File.join(File.dirname(__FILE__) , 'oauth'))#, '..', '..', 'db', name))
    consumer_key_path = File.join(@file_path, "consumer_key.txt")
    consumer_secret_path = File.join(@file_path, "consumer_secret.txt")
    oauth_token_path = File.join(@file_path, "access_token.txt")
    oauth_token_secret_path = File.join(@file_path, "access_token_secret.txt")

    Twitter.configure do |config|
      config.consumer_key       = File.read(consumer_key_path)
      config.consumer_secret    = File.read(consumer_secret_path)
      config.oauth_token        = File.read(oauth_token_path)
      config.oauth_token_secret = File.read(oauth_token_secret_path) 
    end 
      
    TweetStream.configure do |config|
      config.consumer_key       = File.read(consumer_key_path)
      config.consumer_secret    = File.read(consumer_secret_path)
      config.oauth_token        = File.read(oauth_token_path)
      config.oauth_token_secret = File.read(oauth_token_secret_path)  
      config.auth_method = :oauth
    end

    puts "...waiting for player"
    TweetStream::Client.new.track('#dbc_c4') do |status, client|
      #puts status.text
      text = status.text.gsub(/\#dbc_c4/, "").strip
      if text == "bab?"
        client.stop
        puts "@#{status.user[:screen_name]} Game on! #dbc_c4 #{@random_tag}"
        Twitter.update("@#{status.user[:screen_name]} Game on! #dbc_c4 #{@random_tag}")
        return TwitterPlayer.new({name: status.user[:name], twitter: status.user[:screen_name], piece: 'X'})
      end
    end
  end
  
  # def twitter_player
  #   TweetStream::Client.new.track('#dbc_c4') do |status, client|
  #     puts "#{status.text}"
  #     puts "Game on! #dbc_c4" if "#{status.text}" == "Who wants to get demolished?"
  #     client.stop
  #     #Twitter.update("@#{status.user[:screen_name]} Game on! #dbc_c4") if "#{status.text}" == "Who wants to get demolished?"
  #     return TwitterPlayer.new({name: status.user[:name], twitter: status.user[:screen_name], piece: 'X'})
  #   end
  # end

  def move
  	#board = to_a(board_as_string)
    rand(7)
  end


  def board_as_string
    TweetStream::Client.new.track("#{player1.twitter}") do |status, client|
      puts "#{status.text}"
      #look for incoming move
      #Twitter.update("@#{status.user[:screen_name]} Game on! #dbc_c4") if "#{status.text}" == "Who wants to get demolished?"
      client.stop
      return "#{status.text}"
    end
  end

  def to_a(move_string)
    board_info = move_string.gsub(/\|/, "").split("")
    board_info.each { |field| field.gsub!(/\./, "") }
    board_info
  end

  def tweet_board(tweet, message)
    puts "#{player1.twitter} #{tweet} #{message} #{random_tag}"
    #Twitter.update("#{player1.twitter} #{tweet} #{message}")
  end

end