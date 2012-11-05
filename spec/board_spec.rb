require_relative '../lib/board.rb'

describe Board do

	let (:board) {Board.new}
	context "#new" do
	end

	describe "#drop_disc!" do
		context "if the column is full" do
			it "returns true" do
				board.drop_disc!(1,1).should be_true
			end
		end

		context "if the column is full" do
			it "returns false" do
				6.times { board.drop_disc!(1, 1) }
				board.drop_disc!(1,1).should be_false
			end
		end 
	end

	describe "#full?" do
		context "if the board is not full" do
			it "returns false" do
				board.full?.should be_false
			end
		end
	
		context "if the board is full" do
			it "returns true" do
				7.times do |column_index|
					6.times { board.drop_disc!(column_index + 1, 1) }
				end
				board.full?.should be_true
			end
		end
	end

	describe "#from_string" do
		it "returns the board representation" do
			board = Board.from_string("|.......|.......|.......|...XO..|..XOXO.|..OXXO.|")
			board[3][0].should eq 1
			board[3][1].should eq 2
			board[3][2].should eq 1
		end
	end

	describe "#color_of_connect_four" do
		context "if there are no groups of four of the same color" do
			it "should return nil" do
				board.color_of_connect_four.should be_nil
			end
		end

		context "if there is a group of four of the same color" do
			it "should return '1'" do
			end
		end

		context "if there is a group of four 1's in a column" do
		  it "should return '1'" do
		 	  4.times { board.drop_disc!(1, 1) }
		 	  board.color_of_connect_four.should eq(1)
		  end
		end

		context "if there is a group of four of the same color in a row" do
		  it "should return '1'" do
		 	  board.drop_disc!(1, 1)
		 	  board.drop_disc!(2, 1)
		 	  board.drop_disc!(3, 1)
		 	  board.drop_disc!(4, 1)
		 	  board.color_of_connect_four.should eq(1)
		  end
		end

		context "if there is a group of four of the same color in an upward sloping diagonal" do
		  it "should return '2'" do
		 	  3.times { board.drop_disc!(6, 1) }
		 	  2.times { board.drop_disc!(6, 2) }
		 	  board.drop_disc!(5, 1)
		 	  3.times { board.drop_disc!(5, 2) }
		 	  3.times { board.drop_disc!(4, 2) }
		 	  board.drop_disc!(3, 1)
		 	  board.drop_disc!(3, 2)
		 	  board.color_of_connect_four.should eq(2)
		  end

		  	it "should return '1'" do
		 	  3.times { board.drop_disc!(4, 2) }
		 	  1.times { board.drop_disc!(4, 1) }
		 	  3.times { board.drop_disc!(3, 1) }
		 	  2.times { board.drop_disc!(2, 1) }
		 	  board.drop_disc!(1, 1)
		 	  board.color_of_connect_four.should eq(1)
		  end
		end

		context "if there is a group of four of the same color in downward sloping diagonal" do
		  it "should return '1'" do
		  	3.times { board.drop_disc!(1, 2) }
		  	board.drop_disc!(1, 1)
		  	3.times { board.drop_disc!(2, 1) }
		  	2.times { board.drop_disc!(3, 1) }
		 	  board.drop_disc!(4, 1)
		 	  board.color_of_connect_four.should eq(1)
		  end

		  it "should return '1'" do
		  	3.times { board.drop_disc!(2, 2) }
		  	2.times { board.drop_disc!(2, 1) }
		  	3.times { board.drop_disc!(3, 2) }
				board.drop_disc!(3, 1)
				2.times { board.drop_disc!(5, 1) }
				3.times { board.drop_disc!(4, 1) }
		 	  board.color_of_connect_four.should eq(1)
		  end
		end
	end
end