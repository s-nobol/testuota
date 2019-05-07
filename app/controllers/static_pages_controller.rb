class StaticPagesController < ApplicationController
  
  def home
    # 後日修正
    
    
    # 最新の記事
    @eventposts = Eventpost.page(params[:page]).per(6)
    
    # 人気の記事
    # Popular articles
    

  end
  
  def search
    @search = params[:search]
    @eventposts = Eventpost.search(@search).page(params[:page]).per(6)
    
    # @posts = Post.where(['content LIKE ?', "%#{@search}%"]).page(params[:page]).per(6)
  end
  
  def archive
    @yyyymm = params[:yyyymm]
    @eventposts = Eventpost.where("strftime('%Y%m', created_at) = '"+@yyyymm+"'").page(params[:page]).per(6)
  
  end
  
  

end
