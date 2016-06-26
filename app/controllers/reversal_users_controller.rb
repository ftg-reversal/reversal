class ReversalUsersController < ApplicationController
  before_action :set_user, only: [:participate, :activity, :rlog, :event]
  before_action :ensure_permission, only: [:edit, :update, :destroy]

  def index
    users = ReversalUser.including_user.order('updated_at DESC').page(params[:page])
    @users = ReversalUserDecorator.decorate_collection(users)
  end

  def participate
    events = Entry.includes(event: [:reversal_user]).where(reversal_user: @user).map(&:event)
    @events = Kaminari.paginate_array(events).page(params[:page])
  end

  def activity
  end

  def rlog
    @rlogs = Rlog.includes(:reversal_user).where(reversal_user: @user).page(params[:page])
  end

  def event
  end

  private

  def set_user
    @user = ReversalUser.find(params[:id]).decorate
  end

  def ensure_permission
    redirect_to '/' unless @user == @current_user || @current_user.admin?
  end
end
