class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  serialization_scope :view_context

  before_action :set_locale
  before_action :initialize_search_query
  before_action :do_login

  def do_login
    login if session[:user_id]
  end

  def do_check_login
    redirect_to '/' unless @current_user
  end

  def set_locale
    logger.debug "* Accept-Language: #{request.env['HTTP_ACCEPT_LANGUAGE']}"
    I18n.locale = extract_locale_from_accept_language_header
    logger.debug "* Locale set to '#{I18n.locale}'"
  end

  def initialize_search_query
    @q = ''
    @q_type = ''
  end

  private

  def extract_locale_from_accept_language_header
    request.env['HTTP_ACCEPT_LANGUAGE'].scan(/^[a-z]{2}/).first
  end

  def login
    @current_user = ReversalUser.find(session['user_id'])
    session[:user_id] = nil unless @current_user
  rescue
    session[:user_id] = nil
  end
end
