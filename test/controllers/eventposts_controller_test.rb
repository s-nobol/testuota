require 'test_helper'

class EventpostsControllerTest < ActionDispatch::IntegrationTest
  
  
  def setup
    @user = users(:first_user)
    @other_user = users(:second_user)
    @eventpost = eventposts(:eventpost)
  end
  
  # adminユーザー以外でもアクセスできる
  test " show" do
    get eventpost_path(@eventpost)
    assert_response :success
    assert_template "eventposts/show"
  end
  
  # ログインユーザー
  test "new" do
    log_in_as(@other_user)
    get new_eventpost_path
    assert_redirected_to root_path
  end
  
  test "create" do
    log_in_as(@other_user)
    post eventposts_path params: { eventpost: {title: "a" , sub_title:"a" , content:"a"  ,category_id: 1}  }
    assert_redirected_to root_path
  end
  
  test "edit" do
    log_in_as(@other_user)
    get edit_eventpost_path(@eventpost)
    assert_redirected_to root_path
  end
  
  test "update" do
    log_in_as(@other_user)
    patch eventpost_path(@eventpost), params: { eventpost: {title: "a" , sub_title:"a" , content:"a",category_id: 1  }  }
    assert_redirected_to root_path
  end
  
  test "destroy" do
    log_in_as(@other_user)
    delete eventpost_path(@other_user)
    assert_redirected_to root_path
  end
  
  
  # adminユーザーのみアクセスできる
  test "log_in new" do
    log_in_as(@user)
    get new_eventpost_path
    assert_response :success
    assert_template "eventposts/new"
  end 
  
  test "log_in create" do
    log_in_as(@user)
    post eventposts_path params: { eventpost: {title: "a" , sub_title:"a" , content:"a" , category_id: 1 }  }
    follow_redirect!
    assert_template "eventposts/show"
    assert_response :success
  end 
  
  test "log_in edit" do
    log_in_as(@user)
    get edit_eventpost_path(@eventpost)
    assert_template "eventposts/edit"    
    assert_response :success
  end 
  
  test "log_in update" do    
    log_in_as(@user)
    patch eventpost_path(@eventpost), params: { eventpost: {title: "a" , sub_title:"a" , content:"a" , category_id: 1 }  }
    follow_redirect!
    assert_template "eventposts/show"
  end
  
  test "log_in destroy" do
    log_in_as(@user)
    delete eventpost_path(@eventpost)
    assert_redirected_to root_path
    # follow_redirect!
    # assert_template "eventposts/show"
  end
  
end
