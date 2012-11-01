require_relative '../lib/player.rb'


describe Player do
  let (:player) {Player.new(1)}
  context "#initialize" do
    it "should give us the color arguement" do
      player.color.should == 1
    end
  end

  context "#next_move" do
    it "should return an integer less than 8 " do
      player.stub!(:gets).and_return("7")
      player.next_move.should be < 8
    end
  end
end