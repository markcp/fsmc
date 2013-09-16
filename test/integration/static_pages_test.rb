require 'test_helper'

class StaticPagesTest < ActionDispatch::IntegrationTest
  test "Access about page" do
    get "static_pages/about"
    assert_response :success
    assert_select("h1", "About")
  end

  test "Access links page" do
    get "static_pages/links"
    assert_response :success
    assert_select("h1", "Links")
  end
end
