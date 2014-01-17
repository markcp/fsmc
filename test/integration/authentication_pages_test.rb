require 'test_helper'

class AuthenticationPagesTest < ActionDispatch::IntegrationTest
  fixtures :users

  test "signin page exists" do
    get "/signin"
    assert_response :success
  end

  test "signin with invalid information redirects to home page" do
    get "/signin"

    post_via_redirect("/sessions", { session: { email: users(:mark).email, password: 'foo' } })
    path.must_equal('/sessions')
  end

  test "signin with valid information redirects to new viewing page and signout" do
    get "/signin"

    post_via_redirect "/sessions", { session: { email: users(:mark).email, password: 'foobar' } }
    path.must_equal('/movies/search')

    delete_via_redirect "/signout"
    path.must_equal('/')
  end

end
