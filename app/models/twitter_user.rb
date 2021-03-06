# == Schema Information
#
# Table name: twitter_users
#
#  id          :integer          not null, primary key
#  uid         :string(255)      not null
#  screen_name :string(255)      not null
#  name        :string(255)      not null
#  icon_url    :string(255)      not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
# Indexes
#
#  index_twitter_users_on_screen_name  (screen_name)
#

class TwitterUser < ApplicationRecord
  has_one :reversal_user, dependent: :destroy

  def update_with_omniauth(auth)
    self.uid = auth['uid']
    self.screen_name = auth['info']['nickname']
    self.name = auth['info']['name']
    self.icon_url = auth['info']['image']
    save!
  end

  class << self
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
