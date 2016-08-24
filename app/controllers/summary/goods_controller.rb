class Summary::GoodsController < ApplicationController
  before_action :do_check_login, only: [:update, :destroy]
  before_action :set_summary
  before_action :set_good, only: [:destroy]

  def update
    good = @summary.goods.create!(
      reversal_user: @current_user,
      link: { title: @summary.title, url: summary_path(@summary) }.to_json
    )
    good.create_activity :update, owner: @current_user

    render nothing: true
  end

  def destroy
    @good.destroy!
    render nothing: true
  end

  def show
    @goods = @summary.goods
  end

  private

  def set_summary
    @summary = Summary.find(params[:summary_id])
  end

  def set_good
    @good = Good.user(@current_user).type('Rlog').id(@summary.id).first
  end
end
