class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  serialization_scope :view_context

  before_action :do_login

  def do_login
    login if session[:user_id]
  end

  def do_check_reversal_login
    redirect_to '/' unless @current_user
  end

  def do_check_any_login
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
