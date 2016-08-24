class Api::RoomsController < ApplicationController
  def index
    render json: Room.all
  end

  def show
    render json: Message.where(room: @room).page(params[:page])
  end
end
