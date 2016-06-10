class EntriesController < ApplicationController
  before_action :set_entry, only: [:destroy]
  before_action :do_check_any_login, only: [:create, :destroy]
  before_action :ensure_permission, only: [:destroy]

  # API
  def create
    entry = EntryFactory.create_from_entry_form(params, @current_user)

    if entry.save
      render json: entry
    else
      render json: entry.errors.full_messages, status: :internal_server_error
    end
  end

  def destroy
    event = @entry.event
    @entry.destroy if event.can_entry?
    redirect_to event, status: :see_other
  end

  private

  def set_entry
    @entry = Entry.find(params[:id])
  end

  def ensure_permission
    if @current_user && @entry.reversal_user == @current_user
      true
    elsif @twitter_user == @entry.twitter_user
      true
    else
      redirect_to '/'
    end
  end
end
