require 'test_helper'

class EventpostsTest < ActiveSupport::TestCase
  # Eventpost から　Eventposts　に変更
  # test "the truth" do
  #   assert true
  # end
  
  def setup
    @eventpost = eventposts(:eventpost)
  end
  
  test " eventpost_valid?" do
    assert @eventpost.valid?
  end
  
  test " ninl_user" do
    @eventpost.user_id = nil
    assert_not @eventpost.valid?
  end
  
  test "title empty?" do
    @eventpost.title = ""
    assert_not @eventpost.valid?
  end
  
  test "sub_title empty?" do
    @eventpost.sub_title = ""
    assert_not @eventpost.valid?
  end
  
  test "content empty?" do
    @eventpost.content = ""
    assert_not @eventpost.valid?, "eventpost.save? = #{@eventpost.save} "
  end
end
