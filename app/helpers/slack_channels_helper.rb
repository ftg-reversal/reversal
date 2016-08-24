module SlackChannelsHelper
  def messages_json(ordered_messages)
    ordered_messages.map { |m| SlackMessageSerializer.new(SlackMessageDecorator.new(m)) }.to_json(root: false)
  end

  def attachment_text_format(text)
    SlackMessageDecorator.new(OpenStruct.new(text: text)).format_text
  end
end
