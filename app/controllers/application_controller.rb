class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  serialization_scope :view_context

  # before_action :recent_activity
  before_action :do_login

  # def recent_activity
  #   activities = PublicActivity::Activity.includes(:owner)
  #                                        .includes(:trackable)
  #                                        .includes(:recipient)
  #                                        .order('updated_at DESC')
  #                                        .limit(100)

  #   @r_activities = activities.select { |activity| !activity.trackable.nil? }.first(10)
  # end

  def do_login
    login if session[:user_id]
  end

  def do_check_login
    redirect_to '/' unless @current_user
  end

  private

  def login
    @current_user = ReversalUser.find(session['user_id'])
    session[:user_id] = nil unless @current_user
  rescue
    session[:user_id] = nil
  end
end
