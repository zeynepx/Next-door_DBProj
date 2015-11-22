require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest

  test "invalid signup information" do
    # get signup_path  # no where to find signup_path, invalid local variable.
    assert_no_difference 'User.count' do
      post users_path, user: { name: "", email: "user@invalid", password: "foo", password_confrimation: "bar"}
    end
    assert_template 'users/new'
  end

  test "valid signup infomation" do
    assert_difference 'User.count', 1 do
      post_via_redirect users_path, user: { name: "Example User", email:"user@example.com",
                                            password: "password", password_confirmation: "password"}
    end
    assert_template 'users/show'
  end

end
