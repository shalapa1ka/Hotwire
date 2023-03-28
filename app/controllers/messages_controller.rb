# frozen_string_literal: true

class MessagesController < ApplicationController
  before_action :set_message, only: %i[edit update]
  def create
    success, @message = Messages::CreateService.call Current.user, message_params

    unless success
      @room = @message.room
      render 'rooms/show'
    end

    flash.now[:success] = 'Message sent!'
  end

  def edit; end

  def update
    Messages::UpdateService.call @message, update_message_params
  end

  private

  def message_params
    params.require(:message).permit(:body, :room_id)
  end

  def update_message_params
    params.require(:message).permit(:body)
  end

  def set_message
    @message = Message.find params[:id]
  end
end
