require 'test_helper'

class MovieTest < ActiveSupport::TestCase
  def setup
    @movie = Movie.new(title: "There Will Be Blood", director: "Paul Thomas Anderson",
                       year: "2012", skandies_year: "2013", short: false)
    @movie.save
  end

  def teardown
    @movie.destroy!
  end

  test "it has a title index equal to title if no beginning article" do
    @movie.title_index.must_equal(@movie.title)
  end

  test "moves 'The' in title index" do
    @movie.title = "The Unspeakable Act"
    @movie.save
    @movie.title_index.must_equal("Unspeakable Act, The")
  end

  test "moves 'A' in title index" do
    @movie.title = "A Simple Man"
    @movie.save
    @movie.title_index.must_equal("Simple Man, A")
  end

  test "moves 'An' in title index" do
    @movie.title = "An Education"
    @movie.save
    @movie.title_index.must_equal("Education, An")
  end
end
