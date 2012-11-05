require 'spec_helper'

describe Board do

  let(:board) { Board.new }
  
  def fake_row_array(index)
    arr = []
    board.col_num.times do |i|
      arr << i + (index * (board.row_num + 1))
    end
    arr
  end
  
  def fake_column_array(index)
    arr = []
    board.row_num.times do |i|
      arr << (i * board.col_num) + index
    end
    arr
  end

  context "#initialize" do
    it "should exist" do
      board.should_not be_nil
    end

    it "accepts a number of columns" do
      board.col_num.should eq 7
    end

    it "accepts a number of rows" do
      board.row_num.should eq 6
    end
  end
  
  context "#empty?" do
    it "initialized board is empty" do
      board.empty?.should be_true
    end
  end
  
  context "#empty_cells" do
    it "should have all cells empty in the initialization" do
      board.empty_cells.should eq(board.col_num * board.row_num)
    end
    it "should change the value if one cell is filled" do
      board.place_piece(1, "anything")
      board.empty_cells.should eq((board.col_num * board.row_num) - 1)
    end
  end

  context "#place_piece" do

    it "places a piece on the board" do
      board.place_piece(1, "anything")
      board.should_not be_empty
    end

    it "places the piece in the correct position" do
      board.place_piece(3, "anything")
      board.cells[37].should_not be_empty
    end

    it "places the correct colored piece on the board" do
      board.place_piece(1, "Striped")
      board.cells[35].should eq "Striped"
    end

    it "doesn't put a piece in an occupied cell" do
      board.place_piece(1, "Striped")
      board.place_piece(1, "Striped")
      board.place_piece(1, "Striped")
      board.cells[21].should eq "Striped"
    end

  end

  context "#full?" do
    it "returns true if the board is full" do
      board.cells.map! { |cell| cell = "tooth fairy"}
      board.should be_full
    end

    it "returns false of the board is not full" do
      board.should_not be_full
    end

  end

   context "#rows" do
     it "has row_num rows" do # TODO: better way for testing this????
       board.rows.length.should eq(board.row_num)
     end
   end

   context "#columns" do
     it "has col_num columns" do # TODO: better way for testing this????
       board.columns.length.should eq(board.col_num)
     end
   end

   context "#get_start_indexes_to_right" do
     it "should have unique index numbers" do
       board.get_start_indexes_to_right(4).uniq.length.should eq(board.get_start_indexes_to_right(4).length)
     end
     it "should only include numbers from the first row and the first column" do
       board.get_start_indexes_to_right(4).should eq ([0,1,2,3,7,14])
     end
     it "should not include any other numbers than the ones from the first row and the first column" do
       board.cells[8..13].each do |num|
         board.get_start_indexes_to_right(4).should_not include(num)
       end
       board.cells[15..41].each do |num|
          board.get_start_indexes_to_right(4).should_not include(num)
        end
     end
     it "should not have index numbers bigger than rows*columns" do
       s_no = board.col_num * board.row_num
       e_no = s_no + 10
       board.cells[s_no..e_no].each do |num|
         board.get_start_indexes_to_right(4).should_not include(num)
       end
     end
     it "should not include the numbers of the first row bigger than 4" do
       s_no = board.col_num - 4
       e_no = board.col_num - 1
       board.cells[s_no..e_no].each do |num|
         board.get_start_indexes_to_right(4).should_not include(num)
       end
     end

   end

   context "#get_start_indexes_to_left" do
     it "should have unique index numbers" do
       board.get_start_indexes_to_left(4).uniq.length.should eq(board.get_start_indexes_to_right(4).length)
     end
     it "should only include numbers from the first row and the last column" do
        board.get_start_indexes_to_left(4).should eq ([3,4,5,6,13,20])
      end
     it "should not include any other numbers than the ones from the first row and the last column" do
       board.cells[7..12].each do |num|
         board.get_start_indexes_to_left(4).should_not include(num)
       end
       board.cells[14..41].each do |num|
         board.get_start_indexes_to_left(4).should_not include(num)
       end
     end
     it "should not have index numbers bigger than rows*columns" do
       s_no = board.col_num * board.row_num
       e_no = s_no + 10
       board.cells[s_no..e_no].each do |num|
         board.get_start_indexes_to_left(4).should_not include(num)
       end
     end
     it "should not include the numbers smaller than 4" do
       s_no = 0
       e_no = 3
       board.cells[s_no..e_no].each do |num|
         board.get_start_indexes_to_left(4).should_not include(num)
       end
     end
   end

   context "#row_index_number" do
     it "returns the indexnumber of the row of a certain field" do
       fake_row_array(4).each do |num|
         board.row_index_number(num).should eq 4
       end
     end
   end

   context "#column_index_number" do
     it "returns the indexnumber of the column of a certain field" do
       fake_column_array(0).each do |num|
         board.column_index_number(num).should eq 0
       end
     end
   end

   context "#diagonal_indexes" do
     it "has a maximum of row_num units when its going to right" do
       board.diagonal_indexes_to_right.each do |diagonal|
         diagonal.length.should <= board.row_num
       end
     end
     it "has a maximum of row_num units when its going to left" do
       board.diagonal_indexes_to_left.each do |diagonal|
          diagonal.length.should <= board.row_num
        end
      end
   end

   context "#diagonals" do
     it "has gathered the empty contents of the cells" do
       board.diagonals[0].should include('')
     end
     it "has gathered the contents of the cells" do
       board.place_piece(6, "Token")
       board.diagonals[0].should include("Token")
     end
   end

   context "#check_four_consecutive?" do
    it "returns true if there are four occupied cells in a row" do
      board.place_piece(1, "Striped")
      board.place_piece(2, "Striped")
      board.place_piece(3, "Striped")
      board.place_piece(4, "Striped")
      board.check_four_consecutive?.should be_true
    end

    it "returns false if there are four occupied cells in a row" do
       board.place_piece(1, "Striped")
       board.place_piece(2, "Striped")
       board.place_piece(3, "Striped")
       board.place_piece(5, "Striped")
       board.check_four_consecutive?.should be_false
     end

    it "returns true if there are four occupied cells in a column" do
       board.place_piece(1, "Striped")
       board.place_piece(1, "Striped")
       board.place_piece(1, "Striped")
       board.place_piece(1, "Striped")
       board.check_four_consecutive?.should be_true
     end

     it "returns false if there are four occupied cells in a row" do
        board.place_piece(1, "Striped")
        board.place_piece(1, "Striped")
        board.place_piece(1, "Striped")
        board.place_piece(5, "Striped")
        board.check_four_consecutive?.should be_false
      end

    it "returns true if there are four occupied cells in a column" do
       board.place_piece(1, "Test")
       board.place_piece(2, "Striped2")
       board.place_piece(2, "Test")
       board.place_piece(3, "Striped2")
       board.place_piece(3, "Striped")
       board.place_piece(3, "Test")
       board.place_piece(4, "Striped")
       board.place_piece(4, "Striped2")
       board.place_piece(4, "Striped")
       board.place_piece(4, "Test")
       board.check_four_consecutive?.should be_true
     end

     it "returns false if there are four occupied cells in a row" do
       board.place_piece(1, "Test_wrong")
       board.place_piece(2, "Striped2")
       board.place_piece(2, "Test")
       board.place_piece(3, "Striped2")
       board.place_piece(3, "Striped")
       board.place_piece(3, "Test")
       board.place_piece(4, "Striped")
       board.place_piece(4, "Striped2")
       board.place_piece(4, "Striped")
       board.place_piece(4, "Test")
       board.check_four_consecutive?.should be_false
     end
  end

  context "#four_consecutive" do
    it "returns false, if a line of the board has not four of the same, consecutive tokens in it" do
      board.four_consecutive?(["a","a","a","b","a"]).should be_false
    end
    it "returns true, if a line of the board has four of the same, consecutive tokens in it" do
      board.four_consecutive?(["a","a","a","a","b"]).should be_true
    end
  end



end