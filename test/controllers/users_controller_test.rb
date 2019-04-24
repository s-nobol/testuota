require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  
  def setup
    @user = users(:first_user) 
  end
  
  test "should get new" do
    get new_user_url
    assert_response :success
  end

  test "should get show" do
    get user_path(@user)
    assert_response :success
  end

  test "should get index" do
    get users_url
    assert_response :success
  end

  # test "should get edit" do
  #   get users_edit_url
  #   assert_response :success
  # end

end
