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
  before_action :set_summary, only: [:show, :edit, :destroy]

  def index
    @summaries = Summary.order('id DESC').page(params[:page]).decorate
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

  def show
  end

  def edit
  end

  def update
    summary = Summary.find(params[:id])
    if summary.update(summary_params)
      render json: summary, root: nil
    else
      raise 'error'
    end
  end

  def destroy
    raise 'permission error' unless @summary.reversal_user == @current_user || @current_user.admin?
    @summary.destroy
    redirect_to root_path
  end

  private

  def set_summary
    @summary = Summary.find(params[:id]).decorate
  end

  def summary_params
    n = params.permit(:title, :description, :slack_channel, slack_messages: [])
    n[:reversal_user] = @current_user
    n[:slack_channel] = SlackChannel.find(params[:slack_channel])
    n[:slack_messages] = n[:slack_messages].uniq.reject(&:empty?).map { |m| SlackMessage.find(m) }
    n
  end
end
