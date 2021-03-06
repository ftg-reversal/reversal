class PagesController < RlogsController
  before_action :set_page, only: [:show, :edit, :update, :destroy]
  before_action :ensure_permission, only: [:edit, :update, :destroy]
  before_action :set_good, only: [:show]

  def index
    @pages = Page.includes(:reversal_user).order('updated_at DESC').page(params[:page])
  end

  def show; end

  def new
    @page = Page.new
  end

  def create
    @page = Page.new(page_params)

    if @page.save
      @page.create_activity :create, owner: @current_user
      redirect_to @page
    else
      render 'new'
    end
  end

  def edit; end

  def update
    if @page.update(page_params)
      @page.create_activity :update, owner: @current_user
      redirect_to @page
    else
      render 'edit'
    end
  end

  def destroy
    @page.destroy
    redirect_to pages_url, status: :see_other
  end

  def search
    @q = params[:text]
    @q_type = 'Page'
    @rlogs = Page
      .search(title_or_description_cont: params[:text])
      .result
      .includes(reversal_user: [:twitter_user, :slack_user])
      .order('updated_at DESC')
      .page(params[:page])
    render 'rlogs/index'
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

  def set_good
    @good = Good.user(@current_user).type('Rlog').id(@page.id).first
  end
end
