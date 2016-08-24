class RoomsController < ApplicationController
  before_action :set_rooms

  def index
  end

  def show
    @room = Room.find_by(url: params[:room_name])
    @messages = Message.where(room: @room).page(params[:page])
  end

  private

  def set_rooms
    @rooms = Room.all
  end
end
