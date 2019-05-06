require 'test_helper'

class PostCtegorysTest < ActionDispatch::IntegrationTest

  # カテゴリの作成と削除
  
  def setup
    @user = users(:first_user)
    @eventposts = eventposts(:eventpost)
    @category = categories(:category1)
  end
  
  # showページにアクセスしたら表示カテゴリが表示されるか？
  test " show" do
    get category_path(@category)
    assert_template "categorys/show"
    # assert_match @category.name, response.body
    assert_select "a[href=?]", category_path(@category)
    
  end
  
  
  test "category create" do
    log_in_as(@user)
    get new_category_path
    assert_template "categorys/new"
    
    # 無効なデータを送信
    assert_no_difference "Category.count" do
      post categorys_path params: { category: { name: ""} }
    end
    assert_template "categorys/new"

    
    # 有効なデータを送信
    name="category_test_name"
    assert_difference "Category.count", 1 do
      post categorys_path params: { category: { name: name} }
    end
    assert_redirected_to new_category_path
    follow_redirect!
    assert_template "categorys/new"
    assert_not flash.empty?
    
    assert_match name, response.body
    
   
    
  end 
  
  test "category destroy" do
    
    log_in_as(@user)
    get new_category_path
    assert_template "categorys/new" 
    
    # データを削除する
    name = @category.name
    assert_difference "Category.count", -1 do
      delete category_path(@category) 
    end
    
    assert_redirected_to new_category_path
    follow_redirect!
    assert_template "categorys/new"
    assert_not flash.empty?
    
    assert_no_match name, response.body
  end
end
