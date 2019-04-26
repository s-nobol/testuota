class CommentsController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]
  before_action :comment_correct_user,   only: [:create, :destroy]
  before_action :no_post_user, only: [:destroy]
  
  def create
    @post = Post.find(params[:post_id]) 
    @comment = @post.comments.new(content: params[:comment][:content] , user: current_user)
    
    if @comment.save
      flash[:success] = "コメント投稿しました"
      redirect_to post_path(@post)
    else
      @user = @post.user
      @comments = @post.comments.page(params[:page]).per(10)
      flash[:danger] = "投稿できません"
      render "posts/show"
    end
  end
  
  def destroy
    @comment.destroy
    flash[:danger] = "コメント削除しました"
    redirect_to post_path(@post)
  end

  private
    def comment_params
      params.require(:comment).permit(:content)
    end
    
    def no_post_user
      @comment = Comment.find(params[:id])
      @post = @comment.post
      unless @post.user == current_user
        flash[:danger] = "削除できません"
        redirect_to post_path(@post)
      end
    end
    
       # 正しいユーザーかどうか確認
    def comment_correct_user
    end
end
