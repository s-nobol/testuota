require 'test_helper'

class LikesControllerTest < ActionDispatch::IntegrationTest
  
  def setup
    @user = users(:first_user)  
  end
  
  test "should get show" do
    get like_path(@user)
    assert_redirected_to login_path
    
    log_in_as(@user)
    get like_path(@user)
    # assert_template ""
    assert_response :success
  end

end
