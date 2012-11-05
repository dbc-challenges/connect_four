require 'twitter'
require_relative '../board.rb'
require_relative '../player.rb'


Twitter.configure do |config|
  config.consumer_key = "AK1psRA4B88uPvDxPHmAQ"
  config.consumer_secret = "SYNf7wCA8ihLgoxwS77w5BbNkwdtQVb4WyatVW5Q"
  config.oauth_token = "921589320-VkzeZZtWS3UWUlBnhqU7mbSqQoEyP78HO0fuAL70"
  config.oauth_token_secret = "aM2bzq7cKDOj8OI487h0liznOJB2HszcJYrqWBnSo"
end

Twitter.update("hello")