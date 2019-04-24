require 'test_helper'

class UserTest < ActiveSupport::TestCase
  
  def setup
    # @user = users(:first_user)
    @user = User.new(name: "user_name", email: "user_name@user.com", password: "foobar", password_confirmation: "foobar")
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
  
   test "password should be present (nonblank)" do
    @user.password = @user.password_confirmation = " " * 6
    assert_not @user.valid?
  end

  test "password should have a minimum length" do
    @user.password = @user.password_confirmation = "a" * 5
    assert_not @user.valid?
  end
  
  test "name maximum length 50" do
    @user.name="a"*51
    assert_not @user.valid?
  end
  
  
end
