# == Schema Information
#
# Table name: pages
#
#  id               :integer          not null, primary key
#  title            :string(255)      not null
#  description      :text(65535)      not null
#  reversal_user_id :integer          not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
# Indexes
#
#  index_pages_on_reversal_user_id  (reversal_user_id)
#

class PagesController < ApplicationController
  before_action :set_page, only: [:show, :edit, :update, :destroy]
  before_action :do_check_reversal_login, only: [:new, :create, :update, :edit, :destroy]
  before_action :ensure_permission, only: [:edit, :update, :destroy]

  def index
    # TODO: Modelに移す
    @pages = Page.select("'page' as type, id, title, description, updated_at, reversal_user_id")
               .union(Summary.select("'summary' as type, id, title, description, updated_at, reversal_user_id"))
               .includes(:reversal_user).order('updated_at DESC').page(params[:page])
  end

  def show
  end

  def new
    @page = Page.new
  end

  def create
    @page = Page.new(page_params)

    if @page.save
      redirect_to @page
    else
      render 'new'
    end
  end

  def edit
  end

  def update
      if @page.update(page_params)
        redirect_to @page
      else
        render 'edit'
      end
  end

  def destroy
    @page.destroy
    redirect_to pages_url
  end

  private

  def set_page
    @page = Page.find(params[:id])
  end

  def page_params
    n = params.require(:page).permit(:title, :description)
    n[:reversal_user] = @current_user
    n
  end

  def ensure_permission
    redirect_to '/' unless @page.reversal_user == @current_user || @current_user.admin?
  end
end
