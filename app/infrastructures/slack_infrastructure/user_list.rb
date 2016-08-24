class SlackInfrastructure::UserList
  class << self
    # @return [Array<Hash>]
    def exec
      client = SlackInfrastructure::SlackClient.exec
      client.users_list['members'].map do |member|
        {
          user_id: member['id'],
          name: member['name'],
          icon_url: member['profile']['image_48']
        }
      end
    end
  end
end
