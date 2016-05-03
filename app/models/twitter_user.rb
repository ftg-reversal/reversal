# == Schema Information
#
# Table name: twitter_users
#
#  id          :integer          not null, primary key
#  uid         :string(255)
#  screen_name :string(255)
#  name        :string(255)
#  icon_url    :string(255)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class TwitterUser < ActiveRecord::Base
  class << self
    def find_or_create_with_omniauth(auth)
      find_by_uid(auth['uid']) || create_with_omniauth(auth)
    end

    private

    def create_with_omniauth(auth)
      create! do |user|
        user.uid = auth['uid']
        user.screen_name = auth['info']['nickname']
        user.name = auth['info']['name']
        user.icon_url = auth['info']['image']
      end
    end
  end
end
