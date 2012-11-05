require 'spec_helper'

describe Game do

  let(:player1) { Player.new({:name => 'brent', :twitter => 'brent', :password => 'master'}) }
  let(:player2) { Player.new({:name => 'jo', :twitter => 'jauny', :password => 'blah'}) }
  let(:game) { Game.new(player1, player2) }
  
  context '#initialize' do
    it 'has 2 players' do
      game.player1.should be_true
      game.player2.should be_true
    end

    it "has a parameter for winner" do
      game.should respond_to(:winner)
    end

    it "has a board" do
      game.should respond_to(:board)
    end
  end

  context "#toggle_player" do
    it "should change the order of the players" do
      first_player = game.players.first
      second_player = game.players.last
      game.toggle_player
      game.players.first.should eq(second_player)
    end
  end
  
  context "#current_player" do
    it "should return the current player" do
      first_player = game.players.first
      second_player = game.players.last
      game.toggle_player
      game.current_player.should eq(second_player)
    end
  end

end