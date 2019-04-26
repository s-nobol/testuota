require 'test_helper'

class UsersEditTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:first_user)
    @other_user = users(:second_user)
  end

  test "unsuccessful edit" do
    
    log_in_as(@user)
    get edit_user_path(@user)
    assert_template 'users/edit'
    msg = "a"*257
    
    # 失敗するデータ
    patch user_path(@user), params: { user: { message: msg,
                                              address: "",
                                              gender: "",} }
    assert_template 'users/edit' 
    
  end
  
  test "successful edit" do
    
    log_in_as(@user)
    get edit_user_path(@user)
    assert_template 'users/edit'
    
    # 成功するデータ
    msg2 = "test_message"
    address = "tokyo"
    gender = "meil"
    patch user_path(@user), params: { user: { message: msg2,
                                              address: address,
                                              gender: gender,} }
    @user.reload
    assert_equal msg2, @user.message
    assert_equal address, @user.address 
    assert_equal gender, @user.gender
    assert_redirected_to @user
    assert_not flash.empty? 
  end
  
  test "no correcuto user" do
    
    log_in_as(@other_user)
    get edit_user_path(@user)
    # assert_template "users/edit"
    assert_redirected_to root_url
    assert_not flash.empty? 
    
    msg="dont_user"
    patch user_path(@user), params: { user: { message: msg,
                                              address: "tokyo",
                                              gender: "email",} }
    
    assert_redirected_to root_url
    assert_not flash.empty? 
    
    @user.reload
    assert_not_equal @user.message, msg
  end

end
