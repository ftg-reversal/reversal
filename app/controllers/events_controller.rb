# == Schema Information
#
# Table name: events
#
#  id               :integer          not null, primary key
#  title            :string(255)
#  description      :text(65535)
#  datetime         :datetime
#  reversal_user_id :integer
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

class EventsController < ApplicationController
  before_action :set_event, only: [:show, :edit, :update, :destroy]
  before_action :do_check_login, only: [:new, :create, :update, :edit, :destroy]
  before_action :ensure_permission, only: [:edit, :update, :destroy]

  def index
    @events = Event.page(params[:page])
  end

  def show
    @entry = Entry.new
    @entries = Event.find(params[:id]).entry
                 .includes(:chara).includes(:rank).includes(:reversal_user).includes(:twitter_user)
    @user = @current_user || @twitter_user
    @user_entry = Entry.find_by_user(@user)
  end

  def new
    @event = Event.new
  end

  def create
    @event = Event.new(event_params)

    if @event.save
      redirect_to @event
    else
      render action: 'new'
    end
  end

  def edit
  end

  def update
    if @event.update(event_params)
      redirect_to @event
    else
      render action: 'edit'
    end
  end

  def destroy
    @event.destroy
    redirect_to events_url
  end

  def entried
    @event = Event.find(params[:event_id])
  end

  private

  def set_event
    @event = Event.find(params[:id])
  end

  def event_params
    n = params.require(:event).permit(:title, :description, :datetime)
    n[:reversal_user] = @current_user
    n
  end

  def ensure_permission
    redirect_to '/' unless @event.reversal_user == @current_user || @current_user.admin?
  end
end
