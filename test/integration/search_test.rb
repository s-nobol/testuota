require 'test_helper'

class SearchTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  
  # 記事の検索テスト
  def setup
    @eventpost = eventposts(:eventpost)
  end
  
  test "search" do
    get static_pages_home_path
    assert_template "static_pages/home"
    
    # assert_select '#search', search_path
    
    # 無効な検索データ送信
    get eventpost_search_path params: { search: "testtest2" }
    assert_template "static_pages/search"
    
    
    # すべてのポストが表示されない
    eventposts = Eventpost.all
    eventposts.each do |eventpost|
      # assert_select 'a[href=?]', eventpost_path(eventpost), count: 0
      # assert_match eventpost.title, response.body
    end
    
    # 有効な検索を送信
    search = "string"
    get eventpost_search_path params: { search: search }
    assert_template "static_pages/search"
    
    eventposts = Eventpost.where(['title LIKE ?', "%#{search}%"])

    eventposts.page(1).per(6).each do |eventpost|
      assert_select 'a[href=?]', eventpost_path(eventpost)
    end
  end
end
