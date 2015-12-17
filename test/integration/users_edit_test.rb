require 'test_helper'

class UsersEditTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:xiaolong)
  end

  # test "unsuccessful edit" do
  #   log_in_as(@user)
  #   get edit_user_path(@user)
  #   assert_template 'users/edit'
  #   patch user_path(@user), user: { name: '', email: 'wtf@nyu.edu',
  #                                   password: 'wtf', password_confirmation: 'wcisay'}
  #   assert_template 'users/edit'
  # end
  #
  # test "successful edit" do
  #   log_in_as(@user)
  #   get edit_user_path(@user)
  #   assert_template 'users/edit'
  #   name = "Kentucy Tennessee"
  #   email = "georgia@florida.com"
  #   patch user_path(@user), user: { name: name, email: email,
  #                                  password: '', password_confirmation: ''}
  #   assert_not flash.empty?
  #   assert_redirected_to @user
  #   @user.reload
  #   assert_equal @user.name, name
  #   assert_equal @user.email, email
  # end

end
