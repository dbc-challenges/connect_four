require 'spec_helper'

describe Tweet do
	let(:tweet) {Tweet.new}

	describe "#initialize" do
		it "creates a random tag" do
			tweet.random_tag.should be_an_instance_of String
		end
	end

	describe "#twitter_player" do
		it "tracks a keyword" do

		end
	end

end