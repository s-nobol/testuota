require 'test_helper'

class CategorysControllerTest < ActionDispatch::IntegrationTest
  # コントローラーテスト
  def setup
    @user = users(:first_user)
    @other_user =users(:second_user)
    @category = categories(:category1)
  end
  
  # ログインしていないユーザーのアクセス
  test "show" do
    get category_path(@category)
    assert_response :success
  end
  
  test " new" do
    get new_category_path
    assert_redirected_to login_path
  end
  
  test "create" do
    post categorys_path, params: { category: {name: "test" }  }
    assert_redirected_to login_path
  end
  
  test " destroy" do
    delete category_path(@category)
    assert_redirected_to login_path
  end
  
  # 管理者以外のユーザーアクセス
  test "log_in new" do
    log_in_as(@other_user)
    get new_category_path
    assert_redirected_to root_path
  end
  
  test "log_in create" do
    log_in_as(@other_user)
    post categorys_path, params: { category: {name: "test" }  }
    assert_redirected_to root_path
  end
  
  test "log_in destroy" do
    log_in_as(@other_user)
    delete category_path(@category)
    assert_redirected_to root_path
  end
    
  # 管理者によるアクセス  
  test "admin new" do
    log_in_as(@user)
    get new_category_path
  end
  
  test "admin create" do
    log_in_as(@user)
    post categorys_path, params: { category: {name: "test" }  }
    follow_redirect!
    assert_template "categorys/new"
    # assert_response :success
  end
  
  test "admin destroy" do
    log_in_as(@user)
    delete category_path(@category)
    follow_redirect!
    assert_template "categorys/new"
    # assert_response :success
  end
  

  
end
