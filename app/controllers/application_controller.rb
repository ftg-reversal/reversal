class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  serialization_scope :view_context

  before_action :do_login

  def do_login
    if session['user_id']
      user = SlackUser.find_by(uid: session['user_id'])
      @current_user = user.nil? ? nil : ReversalUser.joins(:slack_user).find_by(slack_user_id: user.id)
      session['user_id'] = nil unless @current_user
    end
  rescue
    session['user_id'] = nil
  end

  def do_check_login
    redirect_to '/' unless @current_user
  end
end
