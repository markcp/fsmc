require 'test_helper'

class MovieTest < ActiveSupport::TestCase
  before do
    @movie = Movie.new(title: "There Will Be Blood", director: "Paul Thomas Anderson",
                       year: "2012", skandies_year: "2013", short: false)
  end

  setup { @movie.save }

  it "has a title index equal to title if no beginning article" do
    @movie.title_index.must_equal(@movie.title)
  end

  it "moves 'The' in title index" do
    @movie.title = "The Unspeakable Act"
    @movie.save
    @movie.title_index.must_equal("Unspeakable Act, The")
  end

  it "moves 'A' in title index" do
    @movie.title = "A Simple Man"
    @movie.save
    @movie.title_index.must_equal("Simple Man, A")
  end

  it "moves 'An' in title index" do
    @movie.title = "An Education"
    @movie.save
    @movie.title_index.must_equal("Education, An")
  end
end
