class ApplicationController < ActionController::Base
  
  include SessionsHelper
  
  # ログイン済みユーザーかどうか確認
  def logged_in_user
    unless current_user
      flash[:danger] = "ログインしていません"
      redirect_to login_url
    end
  end
  
  
  # 管理者ユーザーのみがパスできる
  def admin_user
    unless current_user.admin?
      flash[:danger] = "実行権限がありません"
      redirect_to root_path
    end
  end
  
  def links
    @links = User.all
  end
end
