class UsersController < ApplicationController
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "こんにちは#{@user}さん　アカウントの登録が完了しました"
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
  
  private

    def user_params
      params.require(:user).permit(:name, :email, :password)
    end
end
