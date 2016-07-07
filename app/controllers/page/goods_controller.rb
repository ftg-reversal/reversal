class Page::GoodsController < ApplicationController
  before_action :do_check_login, only: [:update, :destroy]
  before_action :set_page
  before_action :set_good, only: [:destroy]

  def update
    good = @page.goods.create!(
      reversal_user: @current_user,
      link: {title: @page.title, url: page_path(@page)}.to_json
    )
    good.create_activity :update, owner: @current_user

    render json: good
  end

  def destroy
    render json: @good.destroy
  end

  def show
    @goods = @page.goods
  end

  private

  def set_page
    @page = Page.find(params[:page_id])
  end

  def set_good
    @good = Good.user(@current_user).type('Rlog').id(@page.id).first
  end
end
