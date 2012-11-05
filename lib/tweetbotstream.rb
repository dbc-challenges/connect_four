require 'tweetstream'
require 'twitter'
require './board.rb'
require './player.rb'

TweetStream.configure do |config|
  config.consumer_key = "AK1psRA4B88uPvDxPHmAQ"
  config.consumer_secret = "SYNf7wCA8ihLgoxwS77w5BbNkwdtQVb4WyatVW5Q"
  config.oauth_token = "921589320-VkzeZZtWS3UWUlBnhqU7mbSqQoEyP78HO0fuAL70"
  config.oauth_token_secret = "aM2bzq7cKDOj8OI487h0liznOJB2HszcJYrqWBnSo"
  config.auth_method        = :oauth
end

Twitter.configure do |config|
  config.consumer_key = "AK1psRA4B88uPvDxPHmAQ"
  config.consumer_secret = "SYNf7wCA8ihLgoxwS77w5BbNkwdtQVb4WyatVW5Q"
  config.oauth_token = "921589320-VkzeZZtWS3UWUlBnhqU7mbSqQoEyP78HO0fuAL70"
  config.oauth_token_secret = "aM2bzq7cKDOj8OI487h0liznOJB2HszcJYrqWBnSo"
end

def game_on?(string)
	string =~ /Game on! #dbc_c4/
end

def valid_response?(string)
	string =~ /@whereskunaldo |.......|.......|.......|.......|.......|.......| #dbc_c4/
end

def make_move(board)
  player = AIPlayer5.new("AI", 1)
	move = player.next_move(board)
	board.drop_disc!(move, 1)
end

def respond_to_board(string, challenger)
	board = Board.from_string(string)
	make_move(board)

  if board.color_of_connect_four == 1
  	Twitter.update("@#{challenger} I win! Good game. #dbc_c4")
  	return true
  elsif board.full?
  	Twitter.update("@#{challenger} Draw game. Play again? #dbc_c4")
  	return true
  else
  	Twitter.update("@#{challenger} #{board.to_twitter_string} #dbc_c4")
  	return false
  end
end

def playgame(challenger)
  board = Board.new
  make_move(board)
  Twitter.update("@#{challenger} #{board.to_twitter_string} #dbc_c4")

	TweetStream::Client.new.userstream do |status|
		if status.user.screen_name == challenger && valid_response?(status.text)
			result = respond_to_board(status.text.gsub!("@whereskunaldo ", "").gsub!(" #dbc_c4", ""), challenger)
			break if result
		end
	end
end

# Twitter.update("Who wants to get demolished? #dbc_c4")

TweetStream::Client.new.userstream do |status|
  if game_on?(status.text)
  	challenger = status.user.screen_name
  	puts challenger
  	playgame(challenger)
  end
end

