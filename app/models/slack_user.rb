# == Schema Information
#
# Table name: slack_users
#
#  id         :integer          not null, primary key
#  uid        :string(255)
#  name       :string(255)
#  icon_url   :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  uid  (uid) UNIQUE
#

class SlackUser < ActiveRecord::Base
  has_one :reversal_user, dependent: :destroy
  has_many :slack_message, dependent: :destroy

  def self.update_from_slack_api_repository
    SlackApiRepository.find_all_users.select(&:validate).map(&:save)
  end
end
