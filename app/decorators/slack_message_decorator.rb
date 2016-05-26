class SlackMessageDecorator < Draper::Decorator
  delegate :current_page, :total_pages, :limit_value, to: :source
  delegate_all

  def permalink
  end

  def username
    object.slack_user&.name || object.username || object.attachments.first['author_name']
  end

  def icon
    object.slack_user&.icon_url || EmojiRepository.find_by_name(object.icon['emoji'].delete(':'))
  rescue
    EmojiRepository.find_by_name('slack')
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
    Time.zone.at(object.ts)
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
