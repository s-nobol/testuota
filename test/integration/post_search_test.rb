require 'test_helper'

class PostSearchTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  # ポストの検索テスト
  def setup
    @post = posts(:first_post)
  end
  
  test "search" do
    get posts_path
    assert_template "posts/index"
    
    # assert_select '#search', search_path
    
    # 無効な検索データ送信
    get post_search_path params: { search: "test" }
    assert_template "posts/search"
    
    # すべてのポストが表示されない
    posts = Post.all
    posts.each do |post|
      assert_select 'a[href=?]', post_path(post), count: 0
    end
    
    # 有効な検索を送信
    search = "string"
    get post_search_path params: { search: search }
    assert_template "posts/search"
    
    posts = Post.where(['title LIKE ?', "%#{search}%"])

    posts.page(1).per(6).each do |post|
      assert_select 'a[href=?]', post_path(post)
    end
  end
end
