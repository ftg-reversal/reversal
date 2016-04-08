class SessionsController < ApplicationController
  def create
    auth = request.env['omniauth.auth']

    if auth['provider'] == 'slack'
      create_slack(auth)
    elsif auth['provider'] == 'twitter'
      create_twitter(auth)
    end
  end

  def destroy
    session[:user_id] = nil
    session[:token] = nil
    session[:twitter_user_id] = nil
    redirect_to root_path
  end

  private

  def create_slack(auth)
    redirect_to root_path and return unless auth['info']['team_id'] == ENV['SLACK_TEAM_ID']

    SlackApiRepository.find_all_users.select(&:validate).map(&:save)
    slack_user = SlackUser.find_by(uid: auth['uid'])

    ReversalUser.find_by(slack_user: slack_user) || ReversalUser.create_with_omniauth(auth, slack_user)
    session[:user_id] = slack_user.uid
    session[:token] = auth.credentials.token
    redirect_to request.env['omniauth.origin'] || root_path
  end

  def create_twitter(auth)
    twitter_user = TwitterUser.find_by_uid(auth['uid']) || TwitterUser.create_with_omniauth(auth)
    # TODO: UPDATE
    session[:twitter_user_id] = twitter_user.id
    redirect_to request.env['omniauth.origin'] || root_path
  end
end
