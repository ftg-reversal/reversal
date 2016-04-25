class SlackMessageDecorator < Draper::Decorator
  delegate_all

  def permalink
  end

  def format_text
    self.class.processor.call(object.text, SlackDecorator::SlackContext.context)[:output].to_s.html_safe
  end

  def attachment_items
    (object.attachments || []).map { |at| SlackDecorator::AttachmentParser.exec(at) }.compact
  end

  def image
    object['file'] if object.file && object.file['mimetype'].include?('image')
  end

  def date
    Time.at(object.ts)
  end

  class << self
    def processor
      @prosessor ||= SlackMarkdown::Processor.new(
        asset_root: '/assets',
        cushion_link: 'https://slack-redir.net/link?url='
      )
    end
  end
end
