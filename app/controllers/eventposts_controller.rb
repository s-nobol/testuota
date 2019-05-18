class EventpostsController < ApplicationController
  before_action :logged_in_user, only: [:new, :create, :edit, :update, :destroy]
  before_action :admin_user,   only: [:new, :create, :edit, :update, :destroy]
  
  def new
    @eventpost = Eventpost.new
    @user = current_user
  end
  
  def create
    @eventpost = current_user.eventposts.build(eventposts_params)
  
    respond_to do |wants|
      if @eventpost.save
        flash[:success] = '記事を作成しました'
        wants.html { redirect_to(@eventpost) }
        wants.xml  { render :xml => @eventpost, :status => :created, :location => @eventpost }
      else
        wants.html { render :action => "new" }
        wants.xml  { render :xml => @eventpost.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  def edit
    @eventpost = Eventpost.find(params[:id])
  end
  
  def update
    @eventpost = Eventpost.find(params[:id])
  
    respond_to do |wants|
      if @eventpost.update_attributes(eventposts_params)
        flash[:success] = '記事を更新しました'
        wants.html { redirect_to(@eventpost) }
        wants.xml  { head :ok }
      else
        wants.html { render :action => "edit" }
        wants.xml  { render :xml => @eventpost.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  def destroy
    @eventpost = Eventpost.find(params[:id])
    @eventpost.destroy
  
    respond_to do |wants|
      wants.html { redirect_to(root_path) }
      wants.xml  { head :ok }
    end
  end

  def index
  end
  
  def show
    @eventpost = Eventpost.find(params[:id])
    @eventpost_comment = EventpostComment.new
    @eventpost_comments = @eventpost.eventpost_comments
  end
  
  
  private
  
    def eventposts_params
      params.require(:eventpost).permit(:title, :sub_title, :content, :category_id, :image, :reproduction_url)
    end  
  
    # # 管理者ユーザーのみがパスできる
    # def admin_user
    #   unless current_user.admin?
    #     flash[:danger] = "実行権限がありません"
    #     redirect_to root_path
    #   end
    # end
end
