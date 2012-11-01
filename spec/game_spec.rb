require_relative '../lib/game.rb'
require_relative '../lib/player.rb'
require_relative '../lib/board.rb'

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

  describe "#over?" do
    context "when the board is or isn't full" do
      it "should return true when the board is full" do
         Board.any_instance.stub(:full?).and_return(true)
         @game.over?.should == true
      end
    end

    context "when the board has or doesn't have a connect four" do
      it "should return true when the board has a connect four" do
        Board.any_instance.stub(:color_of_connect_four).and_return(1)
        @game.over?.should == true
      end

      it "should return true when the board has a connect four" do
        Board.any_instance.stub(:color_of_connect_four).and_return(2)
        @game.over?.should == true
      end
      it "should return false when the board doesn't have a connect four" do
        Board.any_instance.stub(:color_of_connect_four).and_return(nil)
        @game.over?.should == false
      end
    end
  end

  describe "#current_player" do
    context "when turn counter is odd" do
      it "should return player 1" do
        @game.current_player.should == player1
      end
    end
    context "when turn counter is even" do
      it "should return player 2" do
        @game.stub!(:turn_counter).and_return(2)
        @game.current_player.should == player2
      end
    end
  end

  describe "#take_turn" do
    context "when the player takes a turn" do
      before(:each) do
        @valid_col = 1
        @invalid_col = 5
        # @move_count = 0
        # Board.any_instance.stub(:drop_disc!) { @move_count < 10 ? false : true }
      end

      it "should return true for a column with available spots" do
        Board.any_instance.stub(:drop_disc!).and_return(true)
        Player.any_instance.stub(:next_move).and_return(@valid_col)
        @game.take_turn.should be_true
      end
      it "should return true for a column with available spots" do
        Board.any_instance.stub(:drop_disc!).and_return(true)
        Player.any_instance.stub(:next_move).and_return(@valid_col)
        @game.take_turn.should be_true
      end
      # it "should return false for a column with no available spots" do
      #   Board.any_instance.stub(:drop_disc!).and_return(false)
      #   Player.any_instance.stub(:next_move).and_return(@invalid_col)
      #   @game.take_turn.should_receive(:take_turn)
      # end
      # it "returns true for a column with available spots" do
      #   @move_count = 10
      #   @game.take_turn.should be_true
      # end
    end
  end


  describe "#winner" do
    context "when the board has a connect four" do
      it "should return the player that color belongs to" do
        Board.any_instance.stub(:color_of_connect_four).and_return(1)
          @game.winner.should == player1
      end
      it "should return the player that color belongs to" do
        Board.any_instance.stub(:color_of_connect_four).and_return(2)
          @game.winner.should == player2
      end
      it "should return a tie if there is no winner" do
        Board.any_instance.stub(:color_of_connect_four).and_return(nil)
        @game.winner.should == "tie"
      end
    end
  end

end

