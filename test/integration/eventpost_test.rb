require 'test_helper'

class EventpostTest < ActionDispatch::IntegrationTest
  
  def setup
    @user = users(:first_user)
    @other_user =users(:second_user)
    @eventpost = eventposts(:eventpost)
    @category = categories(:category1)
  end
  
  
  # 管理者ユーザーによる記事の作成
  test "create_event_post " do
    
    # 管理者ユーザーによる記事の作成
    log_in_as(@user)
    is_logged_in?
    
    get new_eventpost_path
    assert_template "eventposts/new"
    
    # 無効なデータ送信
    assert_no_difference "Eventpost.count" do
      post eventposts_path params: { eventpost: {title: "", sub_title: "", content:"" , category_id: @category.id} }
    end
    assert_template "eventposts/new"
    
    title = "title"
    sub_title = "sub_title"
    content = "content"
    assert_difference "Eventpost.count", 1 do
      post eventposts_path params: { eventpost: {title: title, sub_title: sub_title, content: content, category_id: @category.id } }
    end
    assert_not flash.empty? , ""
    follow_redirect!
    assert_template "eventposts/show"
    
    assert_match title, response.body
    assert_match sub_title, response.body
    assert_match content, response.body
    assert_match @category.name, response.body

  end
  
  
  
  test "edit_event_post " do
    
    # 管理者ユーザーによる記事の作成
    log_in_as(@user)
    is_logged_in?
    
    get edit_eventpost_path(@eventpost)
    assert_template "eventposts/edit"
    
    # 無効なデータ送信
    patch eventpost_path params: { eventpost: {title: "", sub_title: "", content:"" , category_id: @category.id} }
    assert_template "eventposts/edit"
    
    # 有効なデータ送信
    title = "title"
    sub_title = "sub_title"
    content = "content"
    category = categories(:category2)
    patch eventpost_path params: { eventpost: {title: title, sub_title: sub_title, content: content , category_id: category.id } }

    # Viewが正しく表示されているか？
    assert_not flash.empty? , ""
    follow_redirect!
    assert_template "eventposts/show"
    
    assert_match title, response.body
    assert_match sub_title, response.body
    assert_match content, response.body
    assert_match category.name, response.body

  end
  
end
