module SessionHelper
  def auth_url(service)
    if params[:back_to].blank?
      "/auth/#{service}"
    else
      "/auth/#{service}?origin=#{params[:back_to]}"
    end
  end
end
