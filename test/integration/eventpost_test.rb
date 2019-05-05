require 'test_helper'

class EventpostTest < ActionDispatch::IntegrationTest
  
  def setup
    @user = users(:first_user)
    @other_user =users(:second_user)
    @eventpost = eventposts(:eventpost)
  end
  
  test "create_event_post no_admin" do
    
    # ログインせずにアクセス
    get new_eventpost_path
    assert_redirected_to login_path
    assert_not flash.empty? , ""
    
    assert_no_difference "Eventpost.count" do
      post eventposts_path params: { eventpost: {title: "a", sub_title: "a", content:"a" , category_id: 1 } }
    end
    assert_redirected_to login_path
    assert_not flash.empty? , ""
    
    # 管理者以外のユーザーのアクセス
    log_in_as(@other_user)
    get new_eventpost_path
    assert_redirected_to root_path
    assert_not flash.empty? , ""
    
    # 管理者以外のユーザーの記事作成
    assert_no_difference "Eventpost.count" do
      post eventposts_path params: { eventpost: {title: "a", sub_title: "a", content:"a" , category_id: 1 } }
    end
    assert_redirected_to root_path
    assert_not flash.empty? , ""
    
  end
  
  
  test "create_event_post admin" do
    
    # 管理者ユーザーによる記事の作成
    log_in_as(@user)
    is_logged_in?
    
    get new_eventpost_path
    assert_template "eventposts/new"
    
    # 無効なデータ送信
    assert_no_difference "Eventpost.count" do
      post eventposts_path params: { eventpost: {title: "", sub_title: "", content:"" , category_id: 1 } }
    end
    assert_template "eventposts/new"
    
    title = "title"
    sub_title = "sub_title"
    content = "content"
    assert_difference "Eventpost.count", 1 do
      post eventposts_path params: { eventpost: {title: title, sub_title: sub_title, content: content, category_id: 1 } }
    end
    assert_not flash.empty? , ""
    follow_redirect!
    assert_template "eventposts/show"
    
    assert_match title, response.body
    assert_match sub_title, response.body
    assert_match content, response.body
  end
  
  
  
  
  
   test "edit_event_post no_admin" do
     
    # ログインせずにアクセス
    get edit_eventpost_path(@eventpost)
    assert_redirected_to login_path
    assert_not flash.empty? , ""
    
    assert_no_difference "Eventpost.count" do
      patch eventpost_path params: { eventpost: {title: "a", sub_title: "a", content:"a" , category_id: 1 } }
    end
    assert_redirected_to login_path
    assert_not flash.empty? , ""
    
    # 管理者以外のユーザーのアクセス
    log_in_as(@other_user)
    get edit_eventpost_path(@eventpost)
    assert_redirected_to root_path
    assert_not flash.empty? , ""
    
    assert_no_difference "Eventpost.count" do
      patch eventpost_path params: { eventpost: {title: "a", sub_title: "a", content:"a" , category_id: 1 } }
    end
    assert_redirected_to root_path
    assert_not flash.empty? , ""
    
  end
  
  
  test "edit_event_post admin" do
    
    # 管理者ユーザーによる記事の作成
    log_in_as(@user)
    is_logged_in?
    
    get edit_eventpost_path(@eventpost)
    assert_template "eventposts/edit"
    
    # 無効なデータ送信
    patch eventpost_path params: { eventpost: {title: "", sub_title: "", content:"" , category_id: 1 } }
    assert_template "eventposts/edit"
    
    # 有効なデータ送信
    title = "title"
    sub_title = "sub_title"
    content = "content"
    patch eventpost_path params: { eventpost: {title: title, sub_title: sub_title, content: content , category_id: 1 } }

    # Viewが正しく表示されているか？
    assert_not flash.empty? , ""
    follow_redirect!
    assert_template "eventposts/show"
    
    assert_match title, response.body
    assert_match sub_title, response.body
    assert_match content, response.body
  end
  
end
