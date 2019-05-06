require 'test_helper'

class CategoryTest < ActiveSupport::TestCase
  
  # カテゴリのバリテーション
  def setup
    @user = users(:first_user)
    @eventpost = eventposts(:eventpost)
    @category = Category.new( name: "test" )
  end
  
  test "category_valid?" do
    assert @category.valid? ,"comment_save #{@category.save}"
  end
    
  test "name em@ty?" do
    @category.name = ""
    assert_not @category.valid?
  end  
end
