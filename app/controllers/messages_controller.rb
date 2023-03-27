class MessagesController < ApplicationController
  def create
    success, @message = Messages::CreateService.call Current.user, message_params

    unless success
      @room = @message.room
      render 'rooms/show'
    end

    flash.now[:success] = "Message sent!"
  end

  private

  def message_params
    params.require(:message).permit(:body, :room_id)
  end
end