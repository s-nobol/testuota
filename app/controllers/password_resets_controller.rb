class PasswordResetsController < ApplicationController
  before_action :get_user,   only: [:edit, :update]
  before_action :valid_user, only: [:edit, :update]
  before_action :check_expiration, only: [:edit, :update]    # (1) への対応
  def new
  end

  def create
    @user = User.find_by(email: params[:password_reset][:email])
    if @user
      @user.create_reset_digest
      UserMailer.password_reset(@user).deliver_now
      flash[:info] = "メールを送信しましか確認してください。#{edit_password_reset_url(@user.reset_token, email: @user.email)}"
      redirect_to root_url
    else
      flash.now[:danger] = "該当するユーザーが見当たりません"
      render 'new'
    end
  end

  def edit
    
  end
  
  def update
    if params[:user][:password].empty?                  # (3) への対応
      @user.errors.add(:password, :blank)
      render 'edit'
    elsif @user.update_attributes(user_params) # (4) への対応
      
      # ログインする
      session_login(@user)
      cookies_login(@user)
      
      flash[:success] = "パスワードを更新しました"
      redirect_to @user
    else
      render 'edit'                                     # (2) への対応
    end
  end
  private
  
    def user_params
      params.require(:user).permit(:password, :password_confirmation)
    end

    def get_user
      @user = User.find_by(email: params[:email])
    end

    # 正しいユーザーかどうか確認する
    def valid_user
      unless (@user && @user.authenticated?(:reset, params[:id]))
        flash[:danger] = "アクセスできません "
        redirect_to root_url
      end
    end
    
      # トークンが期限切れかどうか確認する
    def check_expiration
      if @user.password_reset_expired?
        flash[:danger] = "Password reset has expired."
        redirect_to new_password_reset_url
      end
    end
end
