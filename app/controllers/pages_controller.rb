class PagesController < RlogsController
  before_action :set_page, only: [:show, :edit, :update, :destroy]
  before_action :ensure_permission, only: [:edit, :update, :destroy]

  def index
    @pages = Page.includes(:reversal_user).order('updated_at DESC').page(params[:page])
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
    redirect_to pages_url, status: :see_other
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
