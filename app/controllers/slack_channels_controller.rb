# == Schema Information
#
# Table name: slack_channels
#
#  id          :integer          not null, primary key
#  cid         :string(255)
#  name        :string(255)
#  topic       :string(255)
#  is_archived :boolean
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
# Indexes
#
#  cid  (cid) UNIQUE
#

class SlackChannelsController < ApplicationController
  before_action :set_channels

  def index
  end

  def show
    @channel = SlackChannel.find(params[:id])
    @history = @channel.slack_message.includes(:slack_user).decorate
  end

  private

  def set_channels
    @channels = SlackChannel.all
  end
end
