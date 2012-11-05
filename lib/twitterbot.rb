require 'twitter'

def id_of_last_tweet
	Twitter.user_timeline("whereskunaldo").first.id
end

def initiation?(string)
	string =~ /Who wants to get demolished?/
end

def response(player)
	"@#{player} Game on! #dbc_c4"
end

Twitter.configure do |config|
  config.consumer_key = "AK1psRA4B88uPvDxPHmAQ"
  config.consumer_secret = "SYNf7wCA8ihLgoxwS77w5BbNkwdtQVb4WyatVW5Q"
  config.oauth_token = "921589320-VkzeZZtWS3UWUlBnhqU7mbSqQoEyP78HO0fuAL70"
  config.oauth_token_secret = "aM2bzq7cKDOj8OI487h0liznOJB2HszcJYrqWBnSo"
end

#respond to all initiation tweets...(since the date of our last tweet)
Twitter.search("#dbc_c4 -rt", since_id: id_of_last_tweet).results.each do |tweet|
	puts "tweet"
	if initiation?(tweet.text)
		Twitter.update(response(tweet.user.name))
	end
end