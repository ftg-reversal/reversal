class MessageExportBatch
  class << self
    def exec
      Message.all.map(&:destroy)

      SlackMessage.where(username: 'twitter').map do |slack_message|
        channel = slack_message.slack_channel
        room = Room.find_by(url: channel.name)
        next if room.nil?
        Message.create!(
          id: slack_message.id,
          room: room,
          reversal_user: nil,
          user_name: 'twitter',
          icon: '/images/twitter.png',
          text: slack_message.text[1..-2],
          created_at: Time.zone.at(slack_message.ts)
        )
      end
    end
  end
end
