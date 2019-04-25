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
      if user && user.authenticated?(cookies[:token])
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
end
