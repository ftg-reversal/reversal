class SlackInfrastructure::SlackClient
  class << self
    Slack.configure { |config| config.token = ENV['SLACK_API_TOKEN'] }

    # @return [Slack::Client]
    def exec
      @client ||= Slack.client
    end
  end
end
