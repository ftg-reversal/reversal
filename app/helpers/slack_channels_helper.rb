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

module SlackChannelsHelper
  def messages_json(ordered_messages)
    ordered_messages.map { |m| MessageApiSerializer.new(SlackMessageDecorator.new(m)) }.to_json(root: false)
  end

  def attachment_text_format(text)
    SlackMessageDecorator.new(OpenStruct.new(text: text)).format_text
  end
end
