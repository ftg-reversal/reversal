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
    redirect_to root_path, status: :see_other
  end

  private

  def validate_team(auth)
    auth['info']['team_id'] == ENV['SLACK_TEAM_ID']
  end

  def create_slack(auth)
    reversal_user = ReversalUser.find_or_create_with_slack(auth)
    save_session_and_redirect(reversal_user, auth)
  end

  def create_twitter(auth)
    reversal_user = ReversalUser.find_or_create_with_twitter(auth)
    save_session_and_redirect(reversal_user, auth)
  end

  def save_session_and_redirect(reversal_user, auth)
    session[:user_id] = reversal_user.id
    session[:token] = auth.credentials.token
    redirect_to redirect_path
  end

  def redirect_path
    request.env['omniauth.origin'] || root_path
  end
end
