require 'test_helper'

class UsersControllerTest < ActionController::TestCase

  def setup
    @user = users(:xiaolong)
    @other_user = users(:xl)
  end

  test "should get new" do
    get :new
    assert_response :success
    assert_select "title", "Sign up | Myhood"
  end

  test "should redirect index when not logged in" do
    get :index
    assert_redirected_to login_url
  end

  test "should redirect following when not logged in" do
    get :following, id: @user
    assert_redirected_to login_url
  end

  test "should redirect followers when not logged in" do
    get :followers, id: @user
    assert_redirected_to login_url
  end

  # test "should redirect destroy when not logged in" do
  #   assert_no_difference 'User.count' do
  #     delete :destroy, id:@user
  #   end
  #   assert_redirected_to login_url
  # end
  #
  # test "should redirect destroy when logged in as a non-admin" do
  #   log_in_as(@other_user)
  #   assert_no_difference 'User.count' do
  #     delete :destroy, id:@user
  #   end
  #   assert_redirected_to login_url
  # end

end
