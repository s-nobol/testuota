require 'test_helper'

class ArchiveTest < ActionDispatch::IntegrationTest
  # アーカイブのテスト
  def setup
    @eventpost = eventposts(:eventpost)
  end
  
  test "eventpost_archives?" do
    
    # ルートにアクセス
    get static_pages_home_path
    assert_template "static_pages/home"
    
    # アーカイブが正しく表示されているか？
    archives = Eventpost.group("strftime('%Y%m', created_at)").order(Arel.sql("strftime('%Y%m', created_at) desc")).count
    archives.each do |days, count|
      
      # リンクが正しく表示されているか？
      archive_text = "#{days[0,4]}年#{days[4,2]}月 (#{count})"
      assert_select 'a[href=?]', archive_path(days), text: archive_text
        
      # リンクをクリック
      get archive_path(days)
      assert_template "static_pages/archive"
      
      # 正しくViewが表示されているか？
      eventposts = Eventpost.where("strftime('%Y%m', created_at) = '"+days+"'").page(1).per(6)
      eventposts.page(1).per(6).each do |eventpost|
        assert_select 'a[href=?]', eventpost_path(eventpost)
      end
    end
    
  end
  
  test "delete_event_posts cound_sezi archive?" do
    
    # ルートにアクセス
    @user = users(:first_user)
    log_in_as(@user)
    get static_pages_home_path
    assert_template "static_pages/home"
        
    # アーカイブをカウント
    archives = Eventpost.group("strftime('%Y%m', created_at)").order(Arel.sql("strftime('%Y%m', created_at) desc")).count
    archives_count = archives.count
    
    # 記事の削除
    @eventpost_may = eventposts(:may)
    delete eventpost_path(@eventpost_may)
    assert_redirected_to root_path
   
    get static_pages_home_path
    assert_template "static_pages/home"
    
    # 再びアーカイブを表示
    re_archives = Eventpost.group("strftime('%Y%m', created_at)").order(Arel.sql("strftime('%Y%m', created_at) desc")).count
     
    # 前のアーカイブと今のアーカイブに違いがあるか？
    assert_not_equal archives_count, re_archives.count
    
    re_archives.each do |days, count|
      
      # リンクが正しく表示されているか？
      archive_text = "#{days[0,4]}年#{days[4,2]}月 (#{count})"
      # なぜかうまくいかなかった
      assert_select 'a[href=?]', archive_path(days), text: archive_text
        
      # リンクをクリック
      get archive_path(days)
      assert_template "static_pages/archive"
      
      # 正しくViewが表示されているか？
      eventposts = Eventpost.where("strftime('%Y%m', created_at) = '"+days+"'").page(1).per(6)
      eventposts.page(1).per(6).each do |eventpost|
        assert_select 'a[href=?]', eventpost_path(eventpost)
      end
    end

    
  end
end
