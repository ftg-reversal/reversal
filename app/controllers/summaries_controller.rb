class SummariesController < RlogsController
  before_action :set_summary, only: [:show, :edit, :update, :destroy]
  before_action :set_messages, only: [:show, :edit]
  before_action :ensure_permission, only: [:edit, :update, :destroy]

  def index
    @summaries = Summary.includes(:reversal_user).order('updated_at DESC').page(params[:page])
  end

  def show
  end

  def new
    @summary = SummaryDecorator.decorate(Summary.new)
  end

  def create
    summary = Summary.new(summary_params)
    if summary.save
      summary.reload
      save_order(summary, @row_order)

      summary.create_activity :create, owner: @current_user, recipient: summary
      render json: summary, root: nil
    else
      raise 'error'
    end
  end

  def edit
  end

  def update
    if @summary.update(summary_params)
      @summary.reload
      save_order(@summary, @row_order)

      @summary.create_activity :create, owner: @current_user, recipient: @summary
      render json: @summary, root: nil
    else
      raise 'error'
    end
  end

  def destroy
    @summary.destroy
    redirect_to root_path, status: :see_other
  end

  private

  def save_order(summary, row_order)
    summary.slack_messages_summaries.map do |message_summary|
      message_summary.row_order = row_order.map(&:to_i).index(message_summary.slack_message_id)
      message_summary.save!
    end
  end

  def set_summary
    @summary = Summary.includes(slack_messages: [:slack_user, :slack_channel]).find(params[:id])
  end

  def set_messages
    @messages = Array.new(@summary.slack_messages.size)
    @summary.slack_messages_summaries.each do |messages_summary|
      @messages[messages_summary.row_order] = @summary.slack_messages
                                                      .detect { |m| m.id == messages_summary.slack_message_id }
                                                      .decorate
    end
  end

  def summary_params
    n = params.permit(:title, :description, :slack_channel, slack_messages: [])
    @row_order = n[:slack_messages]
    n[:reversal_user] = @current_user
    n[:slack_channel] = SlackChannel.find(params[:slack_channel])
    n[:slack_messages] = n[:slack_messages].uniq.reject(&:empty?).map { |m| SlackMessage.find(m) }
    n
  end

  def ensure_permission
    redirect_to '/' unless @summary.reversal_user == @current_user || @current_user.admin?
  end
end
