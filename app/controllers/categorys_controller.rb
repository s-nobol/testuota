class CategorysController < ApplicationController
  before_action :logged_in_user, only: [:new, :create, :destroy]
  before_action :admin_user,   only: [:new, :create,  :destroy]
  
  
  def new
    @user = current_user
    @category = Category.new
    @categorys = Category.all
  end
  
  def create
    
    @categorys = Category.all
    @user = current_user
    
    @category = Category.new(category_params)
    if @category.save
      flash[:success] = "カテゴリーを新規登録しました"
      redirect_to new_category_path
    else
      # flash[:danger] = "正しいデータが入力されていません"
      # redirect_to new_category_path
      render "new"
    end
  end
  
  def destroy 
    @category = Category.find(params[:id])
    @category.destroy
    flash[:success] = "カテゴリーを削除しました"
    redirect_to( new_category_path) 
  end
  
  def show
    @category = Category.find(params[:id])
    @eventposts = @category.eventposts.order(created_at: :desc).page(params[:page]).per(6)
  end
  
  private
   def category_params
      params.require(:category).permit(:name)
   end
end
