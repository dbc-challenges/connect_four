require 'spec_helper'

describe Cluster do

  before(:each) do
    @cluster = Cluster.new
  end

  context "#rows" do
    it "has row_num rows"
  end

  context "#columns" do
    it "has col_num columns"
  end

  context "#get_start_indexes_to_right" do
    it "should have unique index numbers"
    it "should only include numbers from the first row and the first column"
    it "should not include any other numbers than the ones from the first row and the first column"
    it "should not include the numbers of the first row bigger than 4"

  end

  context "#get_start_indexes_to_left" do
    it "should have unique index numbers"
    it "should only include numbers from the first row and the last column"
    it "should not include any other numbers than the ones from the first row and the last column"
    it "should not include the numbers smaller than 4"
  end

  context "#row_index_number" do
    it "returns the indexnumber of the row of a certain field"
  end

  context "#column_index_number" do
    it "returns the indexnumber of the column of a certain field"
  end

  context "#diagonal_indexes" do
    it "has a maximum of row_num units when its going to right"
    it "has a maximum of row_num units when its going to left"
  end

  context "#diagonals" do
    it "has diagonals in both directions"
    it "has gathered the contents of the cells"
  end

  context "#check_four_consecutive?" do
   it "returns true if there are four occupied cells in a row" do
     @cluster.place_piece(1, "Striped")
     @cluster.place_piece(2, "Striped")
     @cluster.place_piece(3, "Striped")
     @cluster.place_piece(4, "Striped")
     @cluster.check_four_consecutive?.should be_true
   end

   it "returns false if there are four occupied cells in a row" do
      @cluster.place_piece(1, "Striped")
      @cluster.place_piece(2, "Striped")
      @cluster.place_piece(3, "Striped")
      @cluster.place_piece(5, "Striped")
      @cluster.check_four_consecutive?.should be_false
    end

   it "returns true if there are four occupied cells in a column" do
      @cluster.place_piece(1, "Striped")
      @cluster.place_piece(1, "Striped")
      @cluster.place_piece(1, "Striped")
      @cluster.place_piece(1, "Striped")
      @cluster.check_four_consecutive?.should be_true
    end

    it "returns false if there are four occupied cells in a row" do
       @cluster.place_piece(1, "Striped")
       @cluster.place_piece(1, "Striped")
       @cluster.place_piece(1, "Striped")
       @cluster.place_piece(5, "Striped")
       @cluster.check_four_consecutive?.should be_false
     end

   it "returns true if there are four occupied cells in a column" do
      @cluster.place_piece(1, "Striped")
      @cluster.place_piece(2, "Striped2")
      @cluster.place_piece(2, "Striped")
      @cluster.place_piece(3, "Striped2")
      @cluster.place_piece(3, "Striped")
      @cluster.place_piece(3, "Striped")
      @cluster.place_piece(4, "Striped")
      @cluster.place_piece(4, "Striped2")
      @cluster.place_piece(4, "Striped")
      @cluster.place_piece(4, "Striped")
      @cluster.check_four_consecutive?.should be_true
    end

    it "returns false if there are four occupied cells in a row" do
      @cluster.place_piece(1, "Striped2")
      @cluster.place_piece(2, "Striped2")
      @cluster.place_piece(2, "Striped")
      @cluster.place_piece(3, "Striped2")
      @cluster.place_piece(3, "Striped")
      @cluster.place_piece(3, "Striped")
      @cluster.place_piece(4, "Striped")
      @cluster.place_piece(4, "Striped2")
      @cluster.place_piece(4, "Striped")
      @cluster.place_piece(4, "Striped")
      @cluster.check_four_consecutive?.should be_false
    end
 end

 context "#four_consecutive" do

 end

end
