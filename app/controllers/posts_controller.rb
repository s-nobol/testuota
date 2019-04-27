class PostsController < ApplicationController
  before_action :logged_in_user, only: [:new, :create, :edit, :update , :destroy]
  before_action :post_correct_user,   only: [:edit, :update, :destroy]
    
  def index
    @posts = Post.all.page(params[:page]).per(30)
  end
  
  def show
    @post = Post.find(params[:id])
    @comments = @post.comments.page(params[:page]).per(10)
  end 


  def new
    @user = current_user
    @post = current_user.posts.build
  end
  
  def create
    @post = current_user.posts.build(post_params)
  
    respond_to do |wants|
      if @post.save
        flash[:success] = '記事作成'
        wants.html { redirect_to(@post) }
        wants.xml  { render :xml => @post, :status => :created, :location => @post }
      else
        flash[:danger] = "記事作成失敗"
        wants.html { render :action => "new" }
        wants.xml  { render :xml => @post.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  def edit
    @post = Post.find(params[:id])
  end
  
  def update
    @post = Post.find(params[:id])
  
    respond_to do |wants|
      if @post.update_attributes(edit_params)
        flash[:success] = '記事を更新しました'
        wants.html { redirect_to(@post) }
        wants.xml  { head :ok }
      else
        flash[:danger] = '内容にエラーがあります'
        wants.html { render :action => "edit" }
        wants.xml  { render :xml => @post.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    
    respond_to do |wants|
      flash[:success] = "記事を削除しました"
      wants.html { redirect_to(current_user) }
      wants.xml  { head :ok }
    end
  end
  
  private
    def post_params
      params.require(:post).permit(:title, :content, :location, :picture, :sound)
    end
    def edit_params
      params.require(:post).permit(:title, :content, :location)
    end
    
       # 正しいユーザーかどうか確認
    def post_correct_user
      @post = current_user.posts.find_by(id: params[:id])
      redirect_to(root_url) if @post.nil?
    end
end