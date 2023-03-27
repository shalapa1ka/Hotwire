class RoomsController < ApplicationController
  before_action :set_room, only: :show
  before_action :room_access, only: :show
  def index
    @rooms = Room.all
  end

  def show
    @message = Message.new room: @room
  end

  private

  def set_room
    @room = Room.find(params[:id])
  end

  def room_access
    unless Current.user.member_of?(Room.find(params[:id]))
      flash[:danger] = "You do not have access to that room."
      redirect_to rooms_path
    end
  end
end