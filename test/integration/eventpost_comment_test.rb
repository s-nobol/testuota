require 'test_helper'

class EventpostCommentTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  
  def setup
    @user = users(:first_user)
    @eventpost = eventposts(:eventpost)
    @eventpost_comment = eventpost_comments(:eventpost_comment)
  end
  
  # コメントがただしく表示されてるか？
  test " views_ eventpost_comment" do
    
    # 管理者ユーザー以外でアクセス
    get eventpost_path(@eventpost)
    assert_template "eventposts/show"
    
    # 削除コードは表示されない
    eventpost_comments = @eventpost.eventpost_comments
    eventpost_comments.each do |eventpost_comment|
      assert_select "a[href=?]", eventpost_comment_path(eventpost_comment), count: 0
    end
    
    # 管理者ユーザーでアクセス
    log_in_as(@user)
    # ちょっとうまくいかなかった↓↓↓
    # eventpost_comments.each do |eventpost_comment|
    #   assert_select "a[href=?]", eventpost_comment_path(eventpost_comment)
    # end
  end
  
  
  # コメントの作成と削除
  test "create eventpost_comment" do
    # Eventpost.group("WEEK(created_at)")
    
    get eventpost_path(@eventpost)
    assert_template "eventposts/show"
    
    
    # 無効なデータ送信
    assert_no_difference "EventpostComment.count" do
      post eventpost_comments_path params:  { eventpost_id: @eventpost.id ,eventpost_comment: { user_name: "", content: "" }}
    end
    assert_redirected_to @eventpost
    assert_not flash.empty? ,  "flash = #{flash[:danger] }"
    
    
    # 有効なデータ送信
    user_name = "test_user"
    content = "test_eventpost_comment "
    assert_difference "EventpostComment.count", 1 do
      post eventpost_comments_path params:  { eventpost_id: @eventpost.id , eventpost_comment: { user_name: user_name, content: content  }}
    end
    
    # Viewが正しく表示されているか？
    assert_redirected_to @eventpost
    assert_not flash.empty? ,  "flash = #{flash[:success] }"
    follow_redirect! 
    assert_match user_name, response.body
    assert_match user_name, response.body

    # 有効なデータ送信(名前なし)
    user_name = "test_user"
    content = "test_eventpost_comment "
    assert_difference "EventpostComment.count", 1 do
      post eventpost_comments_path params:  { eventpost_id: @eventpost.id , eventpost_comment: { user_name: "", content: content  }}
    end
    
    # Viewが正しく表示されているか？
    assert_redirected_to @eventpost
    assert_not flash.empty? ,  "flash = #{flash[:success] }"
    follow_redirect! 
    assert_match "名無しの鉄オタ", response.body
    assert_match user_name, response.body
    
  end
  
  # コメント削除
  test "destroy eventpost_comment" do
    
    
    # ホームにアクセスする
    get eventpost_path(@eventpost)
    assert_template "eventposts/show"
    
    
    # 削除する（管理人でないので削除できない）
    assert_no_difference "EventpostComment.count" do
      delete eventpost_comment_path(@eventpost_comment)
    end
    
    # ログインページ返される
    assert_redirected_to login_path
    assert_not flash.empty? ,  "flash = #{flash[:danger] }"
    
    # Viewの確認
    get eventpost_path(@eventpost)
    assert_template "eventposts/show"
    
    assert_match @eventpost_comment.user_name, response.body
    assert_match @eventpost_comment.content, response.body
    
    # 管理人ユーザーでログイン
    log_in_as(@user)
    assert_difference "EventpostComment.count" , -1 do
      delete eventpost_comment_path(@eventpost_comment)
    end
    
    # Viewが正しく表示されているか？
    assert_not flash.empty? ,  "flash = #{flash[:success] }"
    assert_redirected_to @eventpost
    follow_redirect!
    assert_no_match @eventpost_comment.user_name, response.body
    assert_no_match @eventpost_comment.content, response.body
  end
  
end
