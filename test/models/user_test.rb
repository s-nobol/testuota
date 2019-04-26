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
  
  # ユーザーを消すとPostも消えるか？
  test "associated microposts should be destroyed" do
    @user.save
    @user.posts.create!(title: "test-title", content: "Lorem ipsum")
    assert_difference 'Post.count', -1 do
      @user.destroy
    end
  end
  
  # ユーザーを消すとcommentも消えるか？
  # test "associated microposts should be destroyed" do
  #   @user.save
  #   @user.posts.create!(title: "test-title", content: "Lorem ipsum")
  #   assert_difference 'Post.count', -1 do
  #     @user.destroy
  #   end
  # end
end
