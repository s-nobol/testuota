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
  
  # メールのフォーマットが正しいか？
  test "email validation should accept valid addresses" do
    valid_addresses = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org
                         first.last@foo.jp alice+bob@baz.cn]
    valid_addresses.each do |valid_address|
      @user.email = valid_address
      assert @user.valid?, "#{valid_address.inspect} should be valid"
    end
  end
  
  test "email validation should reject invalid addresses" do
    invalid_addresses = %w[user@example,com user_at_foo.org user.name@example.
                           foo@bar_baz.com foo@bar+baz.com]
    invalid_addresses.each do |invalid_address|
      @user.email = invalid_address
      assert_not @user.valid?, "#{invalid_address.inspect} should be invalid"
    end
  end
  
  test "email addresses should be unique" do
    duplicate_user = @user.dup
    @user.save
    assert_not duplicate_user.valid?
  end
end
