require 'test_helper'

class MoviePagesTest < ActionDispatch::IntegrationTest
  fixtures :movies

  test "search for a previously seen movie" do
    get_via_redirect("/movies/search", { title: "The Shining" })
    assert_equal("/movies/search", path)
  end

  test "search doesn't find previously seen movie" do
    get_via_redirect("/movies/search", { title: "Foo" })
    assert_equal("/movies/new", path)
  end

  test "create a new movie with viewing" do
    assert_difference("Movie.count", +1) do
      post_via_redirect("/movies", movie: { title: "foobar", director: "Tab Smith",
                                            year: "1964", skandies_year: "2012",
                                            short: "0", current_rating: "",
                                            viewings_attributes: { "0" => {
                                            date: "2013-10-08", format_id: "2",
                                            rating: "56", notes: "Notes"
                                          }}})

    end
    assert_template 'show'
  end

  test "edit an existing movie with viewing" do

    assert_no_difference('Movie.count') do
      patch_via_redirect("/movies/" + movies(:the_shining).id.to_s, movie: { title: "The Shining", director: "Stanley Kubrick",
                                          year: "1980", skandies_year: "",
                                          short: "0", current_rating: "",
                                          viewings_attributes: { "0" => {
                                          date: "2013-10-08", format_id: "2",
                                          rating: "60", notes: "Notes"
                                          }}})
    end
    assert_template 'show'
  end
end
