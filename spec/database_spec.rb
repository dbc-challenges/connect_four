require_relative 'spec_helper'

describe DB do
  let(:path) { File.expand_path(File.join(File.dirname(__FILE__), '..', 'db', 'test.db')) }
  let(:db) { DB.create("test.db") }
  after(:each) { system("rm #{path}") }

  context "when there's no database" do
    it "creates a database" do
      db
      File.exists?(path).should be_true
    end

    it "returns a new db connection" do
      db.should be_an_instance_of SQLite3::Database
    end

    it "creates the users table" do
      expect {
        db.execute("SELECT * FROM games;")
      }.to_not raise_error
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