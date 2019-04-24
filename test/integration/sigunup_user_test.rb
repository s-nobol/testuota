require 'test_helper'

class SigunupUserTest < ActionDispatch::IntegrationTest
  # サインアップのテスト
  # def setup
  #   # @user = users(:first_user)
  #   # @other_user = users(:second_user)
  # end
  
  test "user_signup" do
    
    # user/newにアクセス
    get new_user_path
    assert_template "users/new"
    
    # 間違ったデータを送信 
    assert_no_difference "User.count" do
      post users_path, params: {user: {name: "",email: "",password: "dddd", password_confirmation: "foobar"}}
    end
    assert_template "users/new"
    # 間違ったデータを送信
    assert_no_difference "User.count" do
      post users_path, params: {user: {name: "123",email: "132132",password: "dddd", password_confirmation: "foobar"}}
    end
    assert_template "users/new"
    
    # 正しいデータを送信
    name = "test_user"
    email = "test_user@test.com"
    assert_difference "User.count",1 do
      post users_path, params: {user: {name: name, email: email, password: "password", password_confirmation: "password"}}
    end
    # assert_redirected_to @user
    follow_redirect!
    assert_template "users/show"
    
    assert_not flash.empty? , "フラッシュ = #{flash[:success]}"
    assert_match name, response.body
    assert_match email, response.body
  end
  
  # 別のユーザーでの登録
  test "otheruer_signup" do
    
    # user/newにアクセス
    get new_user_path
    assert_template "users/new"
    
    # 間違ったデータを送信 
    assert_no_difference "User.count" do
      post users_path, params: {user: {name: "",email: "",password: "dddd", password_confirmation: "foobar"}}
    end
    assert_template "users/new"
    # 間違ったデータを送信
    
    # 正しいデータを送信
    name = "test_user"
    email = "test_user@test.com"
    assert_difference "User.count",1 do
      post users_path, params: {user: {name: name, email: email, password: "password", password_confirmation: "password"}}
    end
    # assert_redirected_to @user
    follow_redirect!
    assert_template "users/show"
    
    assert_not flash.empty? , "フラッシュ = #{flash[:success]}"
  end
  
  
end
