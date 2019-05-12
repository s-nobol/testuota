class StaticPagesController < ApplicationController
  
  def home
    # 最新の記事
    @eventposts = Eventpost.page(params[:page]).per(6)
  end
  
  def search
    @search = params[:search]
    @eventposts = Eventpost.search(@search).page(params[:page]).per(6)
    
    # @posts = Post.where(['content LIKE ?', "%#{@search}%"]).page(params[:page]).per(6)
  end
  
  def archive
    @yyyymm = params[:yyyymm]
     # Railsでブログアプリに月別アーカイブを導入(参考)
    if Rails.env.production?
      # @eventposts = Eventpost.where("DATE(created_at) BETWEEN '2019-2-01' AND '2019-5-11'")
      @eventposts = Eventpost.where("date_trunc('month', created_at ) = '#{@yyyymm[0,4]}-#{@yyyymm[4,6]}-01'").page(params[:page]).per(6)
      
      # @eventposts = Eventpost.where("date_part('year' ,created_at)","date_part('month' ,created_at)").page(params[:page]).per(6)
      #うまくいったっぽい
    else
      @eventposts = Eventpost.where("strftime('%Y%m', created_at) = '"+@yyyymm+"'").page(params[:page]).per(6)
    end
    
      # WHERE DATE(created_at) BETWEEN '2019-2-01' AND '2019-5-11'

  end
  
  
end
