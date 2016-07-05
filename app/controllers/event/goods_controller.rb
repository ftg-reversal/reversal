class Event::GoodsController < ApplicationController
  before_action :do_check_login, only: [:update, :destroy]
  before_action :set_event
  before_action :set_good, only: [:destroy]

  def update
    render json: @event.goods.create!(reversal_user: @current_user)
  end

  def destroy
    render json: @good.destroy
  end

  def show
    @goods = @event.goods
  end

  private

  def set_event
    @event = Event.find(params[:event_id])
  end

  def set_good
    @good = Good.user(@current_user).type('Event').id(@event.id).first
  end
end
