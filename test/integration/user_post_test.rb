require 'test_helper'

class UserPostTest < ActionDispatch::IntegrationTest
  
  # 記事の作成と削除
  # include ApplicationHelper

  def setup
    @user = users(:first_user)
    @post = posts(:first_post) 
  end

  test "my pages_ posts" do
    get user_path(@user)
    assert_template 'users/show'
    assert_match  @user.name, response.body
    assert_match @user.posts.count.to_s, response.body
    
    # ページネーションなし
    @user.posts.each do |post|
      assert_select  "a[href=?]", post_path(post)
    end
    
    # ページネーションあり
    # assert_select 'div.pagination'
    # @user.posts.paginate(page: 1).each do |post|
    #   assert_match post.content, response.body
    # end
  end
  
  
  test "create post" do
    
    # 記事の作成ページにアクセス
    log_in_as(@user)
    get new_post_path
    assert_template 'posts/new'
    
    # 無効な記事を作成
    assert_no_difference "Post.count" do
      post posts_path params: { post: {title: "", content: ""} }
    end
    assert_template "posts/new"
    
    # 有効な記事を作成
    title = "test_title"
    content = "test_content"
    image = "test.jpg"
    assert_difference "Post.count" , 1 do
      post posts_path params: { post: {picture: image,title: title, content: content} }
    end
    # assert_redirected_to @post
    follow_redirect!
    assert_not flash.empty?
    assert_template "posts/show"
    
    # showページに正しい情報が入っているか？
    assert_match title , response.body
    assert_match content , response.body
    
  end
  
  test "edit post" do
    
    # 記事の作成ページにアクセス
    log_in_as(@user)
    get edit_post_path(@post)
    assert_template 'posts/edit'
    
    assert_match @post.title , response.body
    assert_match @post.content , response.body
    
    # 無効な記事を作成
    patch post_path params: { post: {title: "", content: ""} }
    assert_template "posts/edit"
    
    # 有効な記事を作成
    title = "test_title"
    content = "test_content"
    patch post_path params: { post: {title: title, content: content} }
    
    # assert_redirected_to @post
    follow_redirect!
    assert_not flash.empty? ,"flash = #{flash[:success]} title= #{@post.reload.title}"
    assert_template "posts/show"
    
    # showページに正しい情報が入っているか？
    assert_match title , response.body
    assert_match content , response.body
  end
  
end
