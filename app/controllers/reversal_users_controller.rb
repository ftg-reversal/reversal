class ReversalUsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :participate, :activity, :rlog, :event]
  before_action :ensure_permission, only: [:edit, :update]

  def index
    users = ReversalUser.including_user.order('updated_at DESC').page(params[:page]).per(24)
    @users = ReversalUserDecorator.decorate_collection(users)
  end

  def show
    @rlogs = Rlog.includes(:reversal_user).where(reversal_user: @user).page(params[:page])
  end

  def edit
  end

  def update
    if @user.update(user_params)
      @user.create_activity :create, owner: @current_user
      redirect_to user_path(@user.screen_name)
    else
      render 'edit'
    end
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
    @user = ReversalUser.find_by(screen_name: params[:screen_name]).decorate
  end

  def user_params
    n = params.require(:reversal_user).permit(:name, :chara, :rank, :bio, :home)
    n[:chara] = Chara.find(n[:chara])
    n[:rank] = Rank.find(n[:rank])
    n
  end

  def ensure_permission
    redirect_to '/' unless @user == @current_user || @current_user.admin?
  end
end
