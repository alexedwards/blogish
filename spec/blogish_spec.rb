require 'date'
require_relative "../lib/blogish"

describe Blogish do

  before :each do
    Blogish.stub!(:entries).and_return(['2013-02-03_hello-world.mkd', '2013-02-05_an-example-post.mkd', '2013-02-04_another-example-post.mkd'])
    File.stub!(:read).with('2013-02-03_hello-world.mkd').and_return("Hello World\n---\nThis is an introduction.\n\nLorem ipsum dolor et sans.")
    File.stub!(:read).with('2013-02-05_an-example-post.mkd').and_return("An Example Post\n---\nLorem ipsum dolor et sans.")
    File.stub!(:read).with('2013-02-04_another-example-post.mkd').and_return("Another Example Post\n---\nLorem ipsum dolor et sans.")
  end

  describe "#fetch" do

    context "when the slug is invalid" do

      it "should return nil" do
        Blogish.fetch('an-invalid-slug').should be nil
      end

    end

    context "when the slug is valid" do

      it "should return a hash of post information" do
        Blogish.fetch('hello-world').should be_a_kind_of Hash
      end

      it "should contain the title" do
        Blogish.fetch('hello-world')[:title].should eql 'Hello World'
      end

      it "should contain the date" do
        Blogish.fetch('hello-world')[:date].to_s.should eql '2013-02-03'
      end

      it "should contain the slug" do
        Blogish.fetch('hello-world')[:slug].should eql 'hello-world'
      end

      it "should contain the body as html" do
        Blogish.fetch('hello-world')[:body].should eql "<p>This is an introduction.</p>\n\n<p>Lorem ipsum dolor et sans.</p>"
      end

      it "should contain the introductory paragraph as html" do
        Blogish.fetch('hello-world')[:intro].should eql "<p>This is an introduction.</p>"
      end

    end

  end

  describe "#fetch_all" do

    it "should return all entries" do
      Blogish.fetch_all.size.should eql 3
    end

    it "should order the entries most recent first" do
      dates = Blogish.fetch_all.map {|x| x[:date].to_s }
      dates.should eql ["2013-02-05", "2013-02-04", "2013-02-03"]
    end

  end

end