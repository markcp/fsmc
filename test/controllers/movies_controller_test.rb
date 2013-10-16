require 'test_helper'

class MoviesControllerTest < ActionController::TestCase

  test "create action fills current_rating field with latest viewing rating if it's blank in the form" do
    post :create, movie: { title: "foobar", director: "Tab Smith",
                          year: "1964", skandies_year: "2012",
                          short: "0", current_rating: "",
                          viewings_attributes: { "0" => {
                          date: "2013-10-08", format_id: "2",
                          rating: "56", notes: "Notes" }, "1" => {
                          date: "2013-10-09", format_id: "2",
                          rating: "64", notes: "" }
                         }}
    assert_equal Movie.last.current_rating, 64
  end
end
