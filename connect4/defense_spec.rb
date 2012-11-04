require_relative 'defense.rb'

describe Defense do 

  describe '.new' do
    it "should get a new board" do
      Defense.new.board.should be_true
    end
  end

  describe "#avaiable_move" do
    it "should give all available cells" do
      deff = Defense.new
      deff.board.place_piece(1, "red")
      deff.available_moves.should eq [28, 36, 37, 38, 39, 40, 41]
    end
  end

  describe "#cell_rating" do
    it "should rate 0 a lonely cell" do
      deff = Defense.new
      deff.cell_rating_left(36).should eq 0
    end

    it "should rate a cell with pieces on the left" do
      deff = Defense.new
      deff.board.place_piece(2, "red")
      deff.cell_rating_left(37).should eq 2
    end

    it "should rate a cell with pieces on the right" do
      deff = Defense.new
      deff.board.place_piece(7, "red")
      deff.cell_rating_right(40).should eq 2
    end

    it "should rate a cell with pieces on the bottom" do
      deff = Defense.new
      deff.board.place_piece(4, "red")
      deff.cell_rating_bottom(31).should eq 2
    end

    it "should not rate a friend-neighbor cell" do
      deff = Defense.new
      deff.board.place_piece(4, "black")
      deff.cell_rating_bottom(31).should eq 0
    end

    it "should rate all the available moves at once" do
      deff = Defense.new
      deff.board.place_piece(7, "red")
      deff.rate_all_cells.should eq ({1=>0, 2=>0, 3=>0, 4=>0, 5=>0, 6=>2, 7=>0})
    end
  end

  describe "#play" do
    it "should play the highest rated move" do
      deff = Defense.new
      deff.board.place_piece(7, "red")
      deff.play
      deff.board.cells.should eq ["", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "black", "red"]
    end

    it "should clear the grades hash" do
      deff = Defense.new
      deff.board.place_piece(7, "red")
      deff.play
      deff.positions_ratings.should be_empty
    end
  end


end