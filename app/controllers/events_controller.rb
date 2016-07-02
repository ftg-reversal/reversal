class EventsController < ApplicationController
  before_action :set_event, only: [:show, :edit, :update, :destroy]
  before_action :do_check_login, only: [:new, :create, :update, :edit, :destroy]
  before_action :ensure_permission, only: [:edit, :update, :destroy]

  def index
    @events = Event.upcoming.recently.page(params[:page])
  end

  def archived
    @events = Event.finished.recently.page(params[:page])
    render 'index'
  end

  def show
    @entry = Entry.new
    @entries = Event.including_entry.find(params[:id]).entry
    @user = @current_user
    @user_entry = Entry.find_by(reversal_user: @user)
  end

  def new
    @event = Event.new
  end

  def create
    parameter = EventParameter.new(params[:event], @current_user)
    @event = Event.new(parameter.to_h)

    if @event.save
      redirect_to @event
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    parameter = EventParameter.new(params[:event], @current_user)

    if @event.update(parameter.to_h)
      redirect_to @event
    else
      render 'edit'
    end
  end

  def destroy
    @event.destroy
    redirect_to events_url, status: :see_other
  end

  private

  def set_event
    @event = Event.find(params[:id])
  end

  def ensure_permission
    redirect_to '/' unless @event.reversal_user == @current_user || @current_user.admin?
  end
end
