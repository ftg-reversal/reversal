class RlogsController < ApplicationController
  before_action :do_check_login, only: [:new, :create, :update, :edit, :destroy]
  before_action :ensure_permission, only: [:edit, :update, :destroy]

  def index
    @rlogs = Rlog.includes(:reversal_user).order('updated_at DESC').page(params[:page])
  end

  private

  def ensure_permission
    redirect_to '/' unless @rlog.reversal_user == @current_user || @current_user.admin?
  end
end
