require 'test_helper'

class Eventpost_CommentTest < ActiveSupport::TestCase
  
  def setup
    @user = users(:first_user)
    @eventpost = eventposts(:eventpost)
    @eventpost_comment = @eventpost.eventpost_comments.new(content: "test_content" )
  end
  
  test "user_valid?" do
    assert @eventpost_comment.valid? ," @eventpost_comment_save #{@eventpost_comment.save}"
  end
  
  test "user_name.empty?save" do
    @eventpost_comment.user_name= ""
    assert  @eventpost_comment.valid?
  end  
  
  test "user nil" do
    @eventpost_comment.eventpost_id = nil
    assert_not  @eventpost_comment.valid?, "@eventpost_comment_save #{@eventpost_comment.save}"
  end  
  

  test "content empty?l" do
    @eventpost_comment.content = ""
    assert_not  @eventpost_comment.valid?
  end  
      
  test "conten length 256" do
    @eventpost_comment.content = "a" * 257
    assert_not @eventpost_comment.valid?
  end
end
