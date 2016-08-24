class Api::ReversalUsersController < ApplicationController
  def show
    user = ReversalUser.find_by(screen_name: params[:screen_name]).decorate
    render json: ReversalUserSerializer.new(user)
  end
end
