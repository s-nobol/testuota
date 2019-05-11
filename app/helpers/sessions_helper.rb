module SessionsHelper
  
  def session_login(user)
    session[:user_id] = user.id
  end
  
  def cookies_login(user)
    user.create_cookies_digest
    cookies.permanent.signed[:user_id] = user.id
    cookies.permanent[:token] = user.cookies_token
  end
  
  def current_user
    if (user_id = session[:user_id])
      @current_user ||= User.find_by(id: user_id)
    elsif (user_id = cookies.signed[:user_id])
      user = User.find_by(id: user_id)
      if user && user.authenticated?(:cookies, cookies[:token])
        session_login(user)
        @current_user = user
      end
    end
  end
  
  def session_logout
    session.delete(:user_id)
    @current_user = nil
  end
  
  def cookies_logout
    current_user.forget
    cookies.delete(:user_id)
    cookies.delete(:token)
  end
  
  # ポストの作成写真がログインユーザーか？
  def post_user(post)
    if post.user == current_user
      post
    end
  end
  
   # もしコメントユーザーとログインユーザーが違うと削除できない
  def comment_destroy(comment)
    if comment.user == current_user #|| current_user.admin?
      comment
    end
  end
  
  # login_userか？
  def current_user?(user)
    if !current_user.nil?
      if user == current_user
        user
      end
    end
    
  end
  
  def admin_user
    if !current_user.nil?
        if current_user.admin?
          true
        end
    end
  end
  
  # 現在時間をクッキーに記録
  def login_time(user)
    if user == current_user
      user.create_login_time
    end
  end
  
  # 記憶したURL (もしくはデフォルト値) にリダイレクト
  # def redirect_back_or(default)
  #   redirect_to(session[:url] || default)
  #   session.delete(:url)
  # end

  # アクセスしようとしたURLを覚えておく
  # def store_location
  #   session[:url] = request.original_url if request.get?
  # end
end
