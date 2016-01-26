module SlackHelper
  def attachment_text_format(text)
    SlackMessageDecorator.new(OpenStruct.new(text: text)).format_text
  end
end
