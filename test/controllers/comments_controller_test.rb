require 'test_helper'

class CommentsControllerTest < ActionDispatch::IntegrationTest
  # test "should get new" do
  #   get comments_new_url
  #   assert_response :success
  # end
  
  def setup
    @user = users(:first_user)
    @post = posts(:first_post)
    @comment = comments(:first_comment)
  end
  
  # ログインしていないとアクセスできない
  test "create post" do
    assert_no_difference "Comment.count" do
      post comments_path params: { comment: { content: "test", post: @post } }
    end
    assert_redirected_to login_path 
  end  
  
  test "destroy post" do
    assert_no_difference "Comment.count" do
      delete comment_path(@comment)
    end
    assert_redirected_to login_path
  end
  
  # 別のユーザーが削除することはできない
  test "destroy no post user" do
    
    # first_userでsecond_userが作ったPostを削除する
    # first_userはsecond_postの制作者でないので削除できない
    log_in_as(@user)
    assert_no_difference "Comment.count" do
      delete comment_path(@comment)
    end
    assert_not flash.empty? ,"flash = #{flash[:danger]} comment_user #{@comment.user}"
    assert_redirected_to post_path(@comment.post)
  end
  
end
