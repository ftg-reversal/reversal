class SessionsController < ApplicationController
  def create
    auth = request.env['omniauth.auth']

    if auth['provider'] == 'slack'
      redirect_to root_path unless validate_team(auth)
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

  def validate_team(auth)
    auth['info']['team_id'] == ENV['SLACK_TEAM_ID']
  end

  def create_slack(auth)
    reversal_user = ReversalUser.find_or_create_with_omniauth(auth)
    session[:user_id] = reversal_user.slack_user.uid
    session[:token] = auth.credentials.token
    redirect_to redirect_path
  end

  def create_twitter(auth)
    twitter_user = TwitterUser.find_or_create_with_omniauth(auth)
    # TODO: UPDATE
    session[:twitter_user_id] = twitter_user.id
    redirect_to redirect_path
  end

  def redirect_path
    request.env['omniauth.origin'] || root_path
  end
end
