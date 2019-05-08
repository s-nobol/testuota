class CommentsController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]
  before_action :comment_correct_user,   only: [:create, :destroy]
  before_action :no_post_user, only: [:destroy]
  
  def create
    @post = Post.find(params[:post_id]) 
    @comment = @post.comments.new(content: params[:comment][:content] , user: current_user)
    
    if @comment.save
      flash[:success] = "コメント投稿しました"
      send_comment_mailer(@comment)
      redirect_to post_path(@post)
    else
      @user = @post.user
      @comments = @post.comments.page(params[:page]).per(10)
      flash[:danger] = "投稿できません コメントの内容を正しく入力してください"
      render "posts/show"
    end
  end
  
  def destroy
    @comment.destroy
    flash[:danger] = "コメント削除しました"
    redirect_to post_path(@comment.post)
  end
  
  def show
    @user = User.find(params[:id])
    @comments = @user.comments.page(params[:page]).per(10)
    
  end

  private
    def comment_params
      params.require(:comment).permit(:content)
    end
    
    def no_post_user
      @comment = Comment.find(params[:id])
      unless comment_destroy(@comment)
        flash[:danger] = "削除できません"
        redirect_to post_path(@comment.post)
      end
    end
    
       # 正しいユーザーかどうか確認
    def comment_correct_user
    end
    
    def send_comment_mailer(comment)
      
      # @postユーザーのメール設定がTrueならメール送信
      if @post.user != current_user 
        if @post.user.notice_email.present?
          UserMailer.comment(comment).deliver_now
        end
      end
    end
    
end
