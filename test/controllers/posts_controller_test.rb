require 'test_helper'

class PostsControllerTest < ActionDispatch::IntegrationTest  
  def setup
    @post = posts(:first_post)
    # posts_path, params: { post: {title: "teitle", content: "Lorem ipsum" } }
    @user = users(:first_user)
  
  end
  
  
  # ログインなしでもアクセスできる
  test "show" do
    get post_path(@post) 
    assert_response :success
  end
  


    # ログインしてないとアクセスできない
  test "should get new" do
    get new_post_path 
    assert_redirected_to login_url
  end
  
  test "create  not logged in" do
    assert_no_difference 'Post.count' do
      post posts_path, params: { post: {title: "teitle", content: "Lorem ipsum" } }
    end
    assert_redirected_to login_url
  end
  
  test "edit not logged in" do
    get edit_post_path(@post)
    assert_redirected_to login_url
  end
  
  test "update not logged in" do
    patch post_path(@post), params: { post: {title: "teitle", content: "Lorem ipsum" } }
    assert_redirected_to login_url
  end

  
  test "destroy  not logged in" do
    assert_no_difference 'Post.count' do
      delete post_path(@post)
    end
    assert_redirected_to login_url
  end
  
  # current_userと違うユーザーはアクセスできない
  test "edit not correct_user" do
    log_in_as(@user)
    post = posts(:second_post)
    get edit_post_path(post)
    assert_redirected_to root_url
  end
  
  test "update not correct_user" do
    log_in_as(@user)
    post = posts(:second_post)
    patch post_path(post), params: { post: {title: "teitle", content: "Lorem ipsum" } }
    assert_redirected_to root_url
  end
  
  test " destroy post correct_user" do
    # @user = users(:first_user)
    log_in_as(@user)
    post = posts(:second_post)
    assert_no_difference 'Post.count' do
      delete post_path(post)
    end
    assert_redirected_to root_url
  end

end
