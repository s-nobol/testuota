require 'test_helper'

class UserTest < ActiveSupport::TestCase
  
  def setup
    @user = users(:first_user)
  end
  
  test "user_valid?" do
    assert @user.valid?
  end
  
  test "name empty?" do
    @user.name=""
    assert_not @user.valid?
  end  
  
  test "email empty?" do
    @user.email=""
    assert_not @user.valid?
  end  
  
  test "password empty?" do
    @user.password=""
    assert_not @user.valid?
  end
  
  test "name maximum length 50" do
    @user.name="a"*51
    assert_not @user.valid?
  end
  
  test "name minimum length 6" do
    @user.password="a"*5
    assert_not @user.valid?
  end
  
end
