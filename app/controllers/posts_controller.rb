class PostsController < ApplicationController
  before_action :logged_in_user, only: [:new, :create, :edit, :update , :destroy]
  before_action :valid_image, only: [:create]
  before_action :post_correct_user,   only: [:edit, :update, :destroy]
    
  def index
    @postscount = Post.all.count
    @posts = Post.all.page(params[:page]).per(30)
    @index = "text-primary"
  end
  
  def show
    @post = Post.find(params[:id])
    @user = @post.user
    @other_posts = @post.user.posts.limit(5)
    @comments = @post.comments.page(params[:page]).per(10)
    @comment = Comment.new
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
  
  # 検索
  def search
    @search = params[:search]
    # @posts = Post.post_search(@search)
    @postscount = Post.where(['title LIKE ?', "%#{@search}%"]).count
    @posts = Post.where(['title LIKE ?', "%#{@search}%"]).page(params[:page]).per(30)
  end
  
  # 人気一覧ページ
  def popular
    likes_ids = Like.group(:post_id).order(Arel.sql('count(post_id) desc')).limit(50).pluck(:post_id)
    @postscount = Post.where("id IN (?)", likes_ids ).count
    @posts = Post.where("id IN (?)", likes_ids ).page(params[:page]).per(30)
    @popular = "text-primary"
  end
  
  private
    def post_params
      params.require(:post).permit(:title, :content, :location, :picture, :sound)
    end
    def edit_params
      params.require(:post).permit(:title, :content, :location)
    end
    
    # 画像ファイルがあるか検証
    def valid_image
      unless params[:post][:picture]
        flash.now[:danger] = "画像ファイルが挿入されていません"
         @post = current_user.posts.build(post_params)
        render "new"
      end
    end
    
       # 正しいユーザーかどうか確認
    def post_correct_user
      @post = current_user.posts.find_by(id: params[:id])
      redirect_to(root_url) if @post.nil?
    end
end
