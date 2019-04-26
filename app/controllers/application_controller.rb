class ApplicationController < ActionController::Base
  
  include SessionsHelper
  
  # ログイン済みユーザーかどうか確認
  def logged_in_user
    unless current_user
      flash[:danger] = "ログインしていません"
      redirect_to login_url
    end
  end
end
