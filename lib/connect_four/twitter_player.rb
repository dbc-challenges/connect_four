require 'tweetstream'

class TwitterPlayer
  attr_reader :name, :twitter, :piece, :random_tag, :id

  def initialize(options={}, tag)
  	@name = options[:name]
    @twitter = options[:twitter]
    @piece = options[:piece]
    @id = options[:id]
    @random_tag = tag
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
      #puts "id = #{status.user[:id]}, text = #{status.text}"
      text = status.text.gsub(/#.*/, "").strip
      if text == "Who wants to get demolished?"
        client.stop
        puts "@#{status.user[:screen_name]} Game on! #dbc_c4 #{@random_tag}"
        Twitter.update("@#{status.user[:screen_name]} Game on! #dbc_c4 #{@random_tag}")
        return TwitterPlayer.new({name: status.user[:name], twitter: status.user[:screen_name], piece: 'O', id: status.user[:id]}, @random_tag)
      end
    end
  end

  def move
  	board = to_a(board_as_string)
    column = parsed_board(board)
    return column
  end

  def board_as_string
    TweetStream::Client.new.follow("#{@id}") do |status, client|
      raw_board = status.text.gsub!(/#.*/, "")
      board = raw_board.match(/[^@\w*](.*)/).to_s.strip
      client.stop
      return board
    end
  end

  def parsed_board(board_as_array)
    result = nil
    board_as_array 
    board_as_array.each_with_index do |cell, index|
      if cell != UI.game.board.cells[index]
        result = (index % 7) + 1
      end
    end
    return result
  end

  def to_a(move_string)
    board_info = move_string.gsub(/\|/, "").split("")
    board_info.each { |field| field.gsub!(/\./, "") }
    board_info
  end

end