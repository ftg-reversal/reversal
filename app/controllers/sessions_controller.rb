class SessionsController < ApplicationController
  # GET /auth/slack/callback
  def create
    SlackApiRepository.find_all_users.select(&:validate).map(&:save)

    auth = request.env['omniauth.auth']

    redirect_to '/' and return unless auth
    redirect_to '/' and return unless auth['provider'] == 'slack'
    redirect_to '/' and return unless auth['info']['team_id'] == ENV['SLACK_TEAM_ID']

    slack_user = SlackUser.find_by(uid: auth['uid'])
    redirect_to '/' and return unless slack_user

    reversal_user = ReversalUser.find_or_initialize_by(slack_user_id: slack_user.id)
    reversal_user.is_admin = auth.extra.user_info['user']['is_admin']
    reversal_user.save!

    session[:user_id] = slack_user.uid
    session[:token] = auth.credentials.token

    redirect_to '/'
  end

  # DELETE /logout
  def destroy
    session[:user_id] = nil
    session[:token] = nil
    redirect_to '/'
  end
end
