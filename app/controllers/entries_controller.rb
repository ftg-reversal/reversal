class EntriesController < ApplicationController
  before_action :do_check_login, only: [:create, :destroy]
  before_action :set_entry, only: [:destroy]
  before_action :ensure_permission, only: [:destroy]

  def create
    entry = EntryFactory.create_from_entry_form(params, @current_user)

    if entry.save
      entry.create_activity :create, owner: @current_user, recipient: entry.event
      render nothing: true
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
    else
      redirect_to '/'
    end
  end
end
