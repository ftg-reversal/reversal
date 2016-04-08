# == Schema Information
#
# Table name: summaries
#
#  id               :integer          not null, primary key
#  title            :string(255)      not null
#  description      :text(65535)      not null
#  reversal_user_id :integer          not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  slack_channel_id :integer          not null
#
# Indexes
#
#  index_summaries_on_reversal_user_id  (reversal_user_id)
#  index_summaries_on_slack_channel_id  (slack_channel_id)
#

class SummariesController < ApplicationController
  before_action :set_summary, only: [:show, :edit, :update, :destroy]
  before_action :do_check_login, only: [:new, :create, :update, :edit, :destroy]
  before_action :ensure_permission, only: [:edit, :update, :destroy]

  def index
    @summaries = Summary.order('updated_at DESC').page(params[:page]).decorate
  end

  def show
  end

  def new
    @summary = SummaryDecorator.decorate(Summary.new)
  end

  def create
    summary = Summary.new(summary_params)
    if summary.save
      render json: summary, root: nil
    else
      raise 'error'
    end
  end

  def edit
  end

  def update
    if @summary.update(summary_params)
      render json: @summary.object, root: nil
    else
      raise 'error'
    end
  end

  def destroy
    @summary.destroy
    redirect_to root_path
  end

  private

  def set_summary
    @summary = Summary.includes(slack_messages: [:slack_user, :slack_channel]).find(params[:id]).decorate
  end

  def summary_params
    n = params.permit(:title, :description, :slack_channel, slack_messages: [])
    n[:reversal_user] = @current_user
    n[:slack_channel] = SlackChannel.find(params[:slack_channel])
    n[:slack_messages] = n[:slack_messages].uniq.reject(&:empty?).map { |m| SlackMessage.find(m) }
    n
  end
end
