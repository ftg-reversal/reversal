class Event::GoodsController < ApplicationController
  before_action :do_check_login, only: [:update, :destroy]
  before_action :set_event
  before_action :set_good, only: [:destroy]

  def update
    good = @event.goods.create!(
      reversal_user: @current_user,
      link: { title: @event.title, url: event_path(@event) }.to_json
    )
    good.create_activity :update, owner: @current_user

    render nothing: true
  end

  def destroy
    @good.destroy!
    render nothing: true
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
