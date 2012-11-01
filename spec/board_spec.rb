require './lib/board.rb'

describe Board do

  before(:each){ @board = Board.new}

  context "#initialize" do
    it "should exist" do
      @board.should_not be_nil
    end

    it "accepts a number of columns" do
      @board.col_num.should eq 7
    end

    it "accepts a number of rows" do
      @board.row_num.should eq 6
    end

    it "is empty" do
      @board.should be_empty
    end
  end

  context "#place_piece" do

    it "places a piece on the board" do
      @board.place_piece(1, "anything")
      @board.should_not be_empty
    end

    it "places the piece in the correct position" do
      @board.place_piece(3, "anything")
      @board.cells[37].should_not be_empty
    end

    it "places the correct colored piece on the board" do
      @board.place_piece(1, "Striped")
      @board.cells[35].should eq "Striped"
    end

    it "doesn't put a piece in an occupied cell" do
      @board.place_piece(1, "Striped")
      @board.place_piece(1, "Striped")
      @board.place_piece(1, "Striped")
      @board.cells[21].should eq "Striped"
    end

  end

  context "#full?" do
    it "returns true if the board is full" do
      @board.cells.map! { |cell| cell = "tooth fairy"}
      @board.should be_full
    end

    it "returns false of the board is not full" do
      @board.should_not be_full
    end

  end



end