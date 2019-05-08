class EventpostCommentsController < ApplicationController
  
  before_action :logged_in_user, only: [:destroy]
  before_action :admin_user, only: [:destroy]
  
  def show
    
  end
  
  def create
    @eventpost = Eventpost.find(params[:eventpost_id]) 
    @eventpost_comment = @eventpost.eventpost_comments.create(eventpost_comment_params)
    if @eventpost_comment.save
      flash[:success] = 'コメント投稿しました'
      redirect_to @eventpost
    else
      flash[:danger] = 'コメント投稿できません'
      redirect_to @eventpost
      # render "eventposts/show" 
    end
  end
  
  def destroy
    @eventpost_comment = EventpostComment.find(params[:id])
    @eventpost = Eventpost.find(@eventpost_comment.eventpost_id)
    @eventpost_comment.destroy
    
    flash[:success] = "コメントを削除しました"
    respond_to do |wants|
      wants.html { redirect_to(@eventpost) }
      wants.xml  { head :ok }
    end
  end
  
  
  private
   def eventpost_comment_params
     params.require(:eventpost_comment).permit(:content, :user_name)
   end
end

