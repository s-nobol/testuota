class StaticPagesController < ApplicationController
  
  def home
    # 後日修正
    
    
    # 最新の記事
    @eventposts = Eventpost.page(params[:page]).per(6)
    
    # 人気の記事
    # Popular articles
    
    # カテゴリー
    @categorys = Category.all
    
    # アーカイブ
    # @archive = Eventpost.group("MONTH(date)") #月ごと
    # @archive = Eventpost.group("MONTH(date)").sum(:column) #月ごとの合計値

  end

  def about
  end

  def help
  end

  def agreement
  end

  def policy
  end

  def corporate
  end
end
