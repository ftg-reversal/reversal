# == Schema Information
#
# Table name: slack_users
#
#  id         :integer          not null, primary key
#  uid        :string(255)      not null
#  name       :string(255)      not null
#  icon_url   :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class SlackUser < ActiveRecord::Base
  has_one :reversal_user, dependent: :destroy
  has_many :slack_message, dependent: :destroy

  def self.update_from_slack_api_repository
    SlackApiRepository.find_all_users.select(&:validate).map(&:save)
  end
end
