# == Schema Information
#
# Table name: slack_messages_summaries
#
#  id               :integer          not null, primary key
#  slack_message_id :integer          not null
#  row_order        :integer
#  summary_id       :integer
#
# Indexes
#
#  fk_rails_2a1b919d51                                 (summary_id)
#  index_slack_messages_summaries_on_slack_message_id  (slack_message_id)
#

class SlackMessagesSummary < ActiveRecord::Base
  belongs_to :summary, class_name: 'Rlog'
  belongs_to :slack_message

  default_scope -> { order(:row_order) }
end
