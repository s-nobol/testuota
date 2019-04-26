class UsersController < ApplicationController
  before_action :logged_in_user, only: [:edit, :update]
  before_action :correct_user,   only: [:edit, :update]
  
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      
      # ログインする
      session_login(@user)
      cookies_login(@user)
      
      flash[:success] = "こんにちは#{@user.name}さん　アカウントの登録が完了しました"
      redirect_to @user
    else
      flash[:danger] = "保存できません"
      render "new"
    end
  end

  def show
    @user = User.find(params[:id])
  end
  
  

  def index
    @users= User.all
  end

  def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    if @user && @user.update_attributes(edit_params)
      flash[:success] = "ユーザー情報を更新しました"
      redirect_to @user 
    else
      render "edit"
    end
  end
  
  private

    def user_params
      params.require(:user).permit(:name, :email, :password)
    end
    
    def edit_params
      params.require(:user).permit(:message, :address, :gender ,:birthday, :notice_email, :notice_message)
    end
    
       # 正しいユーザーかどうか確認
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless @user == current_user
    end
end
