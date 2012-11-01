require_relative '../lib/game.rb'
require_relative '../lib/player.rb'

describe Game do
  let (:player1) {Player.new(1)}
  let (:player2) {Player.new(2)}
  # let (:board) {Board.new}
  before :all do
    @game = Game.new(player1, player2)
  end

  describe "#initialize" do
    it "return two players with player instances" do
      @game.player1.should be_an_instance_of Player
      @game.player2.should be_an_instance_of Player
    end

    it "should return two players with either color 1 or color 2" do
      @game.player1.color.should == 1
      @game.player2.color.should == 2
    end

    it "should return a board with a board instance"

    it "should return the correct color for a certain position called on the board"
  end

  # describe "#over?" do
  #   context "when the board is or isn't full" do
  #     it "should return true when the board is full" do
  #        Board.any_instance.stub(:full?).and_return(true)
  #        game.over?.should == true
  #     end
  #     it "should return false when the board is NOT full" do
  #        Board.any_instance.stub(:full?).and_return(false)
  #        game.over?.should == false
  #     end
  #   end
  #
  #   context "when the board has or doesn't have a connect four" do
  #     it "should return true when the board has a connect four" do
  #      Board.any_instance.stub(:four?).and_return(true)
  #      game.over?.should == true
  #     end
  #
  #     it "should return false when the board doesn't have a connect four" do
  #        Board.any_instance.stub(:four?).and_return(false)
  #        game.over?.should == false
  #     end
  #   end
  # end

  describe "#current_player" do
    context "when turn counter is odd" do
      it "should return player 1" do
        @game.current_player.should == player1

      end
    end
    context "when turn counter is even" do
      it "should return player 2" do
        @game.current_player.should == player2
      end
    end
  end


end



class Board
end