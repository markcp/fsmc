require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.new(name: "Example User", email: "user@example.com",
                     password: "foobar", password_confirmation: "foobar")
    @user.save
    @found_user = User.find_by(email: @user.email)
    @user_for_invalid_password = @found_user.authenticate("invalid")
  end

  def teardown
    @user.destroy!
  end

  test "it has an auto-generated remember token" do
    @user.remember_token.wont_equal(nil)
  end

  test "it authenticates with a correct password" do
    @user.must_equal(@found_user.authenticate(@user.password))
  end

  test "does not authenticate with an incorrect password" do
    @user.wont_equal(@user_for_invalid_password)
  end
end
