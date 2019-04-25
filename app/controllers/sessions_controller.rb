class SessionsController < ApplicationController
  
  def new
    @user = User.new
  end
  
  def create 
    @user = User.find_by(email: params[:session][:email])
    if @user && @user.authenticate(params[:session][:password])
      
      # ログインする
      session_login(@user)
      cookies_login(@user)
      
      flash[:success] = "ログインしました"
      redirect_to @user
    else
      flash.now[:danger] = '該当するユーザーが見当たりません'
      render 'new'
    end
  end
  
  def destroy
    
    # ログアウトする
    logout if !current_user.nil?
    
    flash[:success] = "ログアウトしました"
    redirect_to root_path
  end
  
  private 
    def logout
      cookies_logout
      session_logout
    end
end
