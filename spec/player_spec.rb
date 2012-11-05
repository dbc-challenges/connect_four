require 'spec_helper'

describe Player do
  let(:player) { Player.new({ name: "Brent", twitter: "Blah", password: "master" }) }

  describe "#initialize" do
    it "has a name" do
      player.name.should eq "Brent"
    end

    it "has a twitter account" do
      player.twitter.should eq "Blah"
    end

    it "has a password" do
      player.password.should eq "master"
    end
  end
  
end