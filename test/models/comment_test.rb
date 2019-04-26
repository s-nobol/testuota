require 'test_helper'

class CommentTest < ActiveSupport::TestCase
    def setup
        @user = users(:first_user)
        @post = posts(:first_post)
        @comment = Comment.new(content: "test_content", user: @user, post: @post )
    end
    
    test "user_valid?" do
      assert @comment.valid? ,"comment_save #{@comment.save}"
    end
    
    test "user nil" do
      @comment.user= nil
      assert_not @comment.valid?
    end  
    
    test "post ni" do
      @comment.post = nil
      assert_not @comment.valid?
    end  
    
    test "content empty?)" do
      @comment.content = "" 
      assert_not @comment.valid?
    end
    
    test "length 256" do
      @comment.content = "a" * 257
      assert_not @comment.valid?
    end

end
