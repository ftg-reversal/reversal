module SessionHelper
  def auth_url(service)
    if params[:redirect_to].blank?
      "/auth/#{service}"
    else
      "/auth/#{service}?origin=#{params[:redirect_to]}"
    end
  end
end
