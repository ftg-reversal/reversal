# == Schema Information
#
# Table name: slack_messages_summaries
#
#  id               :integer          not null, primary key
#  slack_message_id :integer          not null
#  summary_id       :integer          not null
#  row_order        :integer
#
# Indexes
#
#  index_slack_messages_summaries_on_slack_message_id  (slack_message_id)
#  index_slack_messages_summaries_on_summary_id        (summary_id)
#

class SlackMessagesSummary < ActiveRecord::Base
  belongs_to :summary
  belongs_to :slack_message

  default_scope -> { order(:row_order) }
end
