class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :do_login

  def do_login
    if session['user_id']
      user = SlackUser.find_by(uid: session['user_id'])
      @current_user = ReversalUser.joins(:slack_user).find_by(id: user.id)
      session['user_id'] = nil unless @current_user
    end
  end
end
