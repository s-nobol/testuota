require 'test_helper'

class PostTest < ActiveSupport::TestCase
  def setup
    @user = users(:first_user)
    # このコードは慣習的に正しくない
    # @post = Post.new(title: "test_title" , content: "Lorem ipsum", user_id: @user.id)
    @post = @user.posts.build(title: "test_title" , content: "Lorem ipsum")
  end

  test "should be valid" do
    assert @post.valid?
  end

  test "user id should be present" do
    @post.user_id = nil
    assert_not @post.valid?
  end
  
  
  test "title.empty?" do
    @post.title =""
    assert_not @post.valid?
  end
  test "content.empty?" do
    @post.content = ""
    assert_not @post.valid?
  end
  
  test "title.length 50?" do
    @post.title = "50"*51
    assert_not @post.valid? ,"post.save = #{@post.save}"
  end
  test "content.length 400" do
    @post.content = "a"*401
    assert_not @post.valid?,"post.save = #{@post.save}"
  end
  
  test "order should be most recent first" do
    @post = posts(:first_post)
    @last_post= posts(:last_post)
    assert_equal @last_post, Post.first , "@post.first#{@last_post.created_at} @post.first#{@post.created_at}"
  end
end
