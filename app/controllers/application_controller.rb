class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  serialization_scope :view_context

  before_action :do_login

  def do_login
    if session[:user_id]
      reversal_login
    elsif session[:twitter_user_id]
      twitter_login
    end
  end

  def do_check_reversal_login
    redirect_to '/' unless @current_user
  end

  def do_check_any_login
    redirect_to '/' unless @current_user || @twitter_user
  end

  private

  def reversal_login
    user = SlackUser.find_by(uid: session['user_id'])
    @current_user = user.nil? ? nil : ReversalUser.joins(:slack_user).find_by(slack_user_id: user.id)
    session[:user_id] = nil unless @current_user
  rescue
    session[:user_id] = nil
  end

  def twitter_login
    @twitter_user = TwitterUser.find(session[:twitter_user_id])
    session[:twitter_user_id] = nil unless @twitter_user
  rescue
    session[:twitter_user_id] = nil
  end
end
