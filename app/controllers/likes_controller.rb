class LikesController < ApplicationController
  before_action :set_message
  def create
    Likes::CreateService.call Current.user, @message
  end

  def destroy
    Likes::DestroyService.call Current.user, @message
  end

  private

  def set_message
    @message = Message.find(params[:message_id])
  end
end