module SessionHelper
  def login_with_redirect_url(redirect_to)
    "/login?redirect_to=#{redirect_to}"
  end

  def auth_url(service)
    if params[:redirect_to].blank?
      "/auth/#{service}"
    else
      "/auth/#{service}?origin=#{params[:redirect_to]}"
    end
  end
end
