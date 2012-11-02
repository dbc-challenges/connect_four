require 'spec_helper'

describe Game do

  let(:player1) { Player.new({:name => 'brant', :twitter => 'brant', :password => 'master'}) }
  let(:player2) { Player.new({:name => 'jo', :twitter => 'jauny', :password => 'blah'}) }
  let(:game) { Game.new(player1, player2) }

  describe '.new' do
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



end