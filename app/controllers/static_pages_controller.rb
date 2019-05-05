class StaticPagesController < ApplicationController
  
  def home
    # 後日修正
    @eventposts = Eventpost.all
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
