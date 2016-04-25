module SlackDecorator
  class AttachmentParser
    class << self
      def exec(at)
        if at['service_name'] == 'twitter'
          twitter(at)
        else
          others(at)
        end
      end

      private

      def twitter(at)
        at
      end

      def others(at)
        if at[:title] || at[:text]
          at[:title_link] = "https://slack-redir.net/link?url=#{URI.encode at[:title_link]}" if at[:title_link]
          at
        elsif at[:image_url]
          at[:service_name] = 'reversal-image'
          at
        end
      end
    end
  end
end
