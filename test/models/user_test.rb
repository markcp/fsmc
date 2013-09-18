require 'test_helper'

class UserTest < ActiveSupport::TestCase
  before do
    @user = User.new(name: "Example User", email: "user@example.com",
                     password: "foobar", password_confirmation: "foobar")
  end

  setup { @user.save }
  let(:found_user) { User.find_by(email: @user.email) }

  it "has an auto-generated remember token" do
    @user.remember_token.wont_equal(nil)
  end

  it "authenticates with a correct password" do
    @user.must_equal(found_user.authenticate(@user.password))
  end

  let(:user_for_invalid_password) { found_user.authenticate("invalid") }

  it "does not authenticate with an incorrect password" do
    @user.wont_equal(user_for_invalid_password)
  end
end
