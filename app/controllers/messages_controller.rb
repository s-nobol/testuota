class MessagesController < ApplicationController
  
  before_action :logged_in_user, only: [:create, :destroy, :show]

  def show
    @user = User.find(params[:id])
    @messages = @user.comment_messages
  end
end
