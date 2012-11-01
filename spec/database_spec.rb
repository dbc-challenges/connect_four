require './lib/database.rb'

describe DB do
  before(:each) { @db = DB.create("test.db") }
  after(:each) { system("rm test.db") }

  context "when there's no database" do
    it "creates a database" do
      File.exists?("test.db").should be_true
    end

    it "returns a new db connection" do
      @db.should be_an_instance_of SQLite3::Database
    end

    it "creates the users table" do
      @db.execute("SELECT * FROM games;").should_not raise_error
    end
  end

  context "when there is already a database" do
    # it "does not creates a new database" do
    #   db = DB.create("test.rb")
    #   db.execute("INSERT INTO players (name, twitter, password) VALUES ('brent', 'brent', 123);")
    #   db = DB.create("test.rb")
    #   db.execute("SELECT COUNT(*) FROM players").should eq 1
    # end

  end


end