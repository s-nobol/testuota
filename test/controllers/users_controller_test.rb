require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  
  def setup
    # @user = users(:first_user) 
    @user = User.new(name: "user_name", email: "user_name@user.com", password: "foobar", password_confirmation: "foobar")
  end
  
  test "should get new" do
    get new_user_url
    assert_response :success
  end

  # test "should get show" do
  #   get user_path(@user)
  #   assert_response :success
  # end

  test "should get index" do
    get users_url
    assert_response :success
  end

  # test "should get edit" do
  #   get users_edit_url
  #   assert_response :success
  # end

end
