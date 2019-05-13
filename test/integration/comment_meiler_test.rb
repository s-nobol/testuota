require 'test_helper'

class CommentMeilerTest < ActionDispatch::IntegrationTest
  # コメントメールの送信テスト
  def setup
    @user = users(:first_user)
    @other_user = users(:second_user)
    @post = posts(:first_post)
    ActionMailer::Base.deliveries.clear
  end
  
  test "commetn_send_mailer" do
    
    # @other_userがログインしてコメントする
    log_in_as(@other_user)
    get post_path(@post)
    assert_template "posts/show"
    
    # 無効なコメント送信
    assert_no_difference "Comment.count" do
      post comments_path params: { post_id: @post.id,  comment: { content: ""} }
    end
    
    assert_template "posts/show"
    assert_not flash.empty? , "flash = #{flash[:danger]}"
    
    # コメント送信
    content = "test_comment"
    assert_difference "Comment.count", 1 do
      post comments_path params: { post_id: @post.id, comment: { content: content } }
    end
    assert_redirected_to @post
    assert_not flash.empty? , "flash = #{flash[:success]}"
    assert_equal 1, ActionMailer::Base.deliveries.size
    # assert_match content, response.body
    
    
    # ユーザーのメール設定を変更してメール送信
    # @user.notice_email = false
    @user.toggle!(:notice_email)
    @post = posts(:first_post)
    content = "test_comment2"
    assert_difference "Comment.count", 1 do
      post comments_path params: { post_id: @post.id, comment: { content: content } }
    end
    assert_redirected_to @post
    assert_not flash.empty? , "flash = #{flash[:success]}"
    # 送信したメールの合計
    assert_equal 1, ActionMailer::Base.deliveries.size
  end
  
  
  # 自分のポストにコメントする場合反映されない
  test "not_send_email" do
    
    # @other_userがログインしてコメントする
    log_in_as(@user)
    get post_path(@post)
    assert_template "posts/show"
    
    # 無効なコメント送信///////////////////
    assert_no_difference "Comment.count" do
      post comments_path params: { post_id: @post.id,  comment: { content: ""} }
    end
    
    assert_template "posts/show"
    assert_not flash.empty? , "flash = #{flash[:danger]}"
    
    # コメント送信
    content = "test_comment"
    assert_difference "Comment.count", 1 do
      post comments_path params: { post_id: @post.id, comment: { content: content } }
    end
    assert_redirected_to @post
    assert_not flash.empty? , "flash = #{flash[:success]}"
    assert_equal 0, ActionMailer::Base.deliveries.size
    # assert_match content, response.body

  end
end
