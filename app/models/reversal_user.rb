# == Schema Information
#
# Table name: reversal_users
#
#  id            :integer          not null, primary key
#  slack_user_id :integer
#  is_admin      :boolean
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
# Indexes
#
#  slack_user_id  (slack_user_id) UNIQUE
#

class ReversalUser < ActiveRecord::Base
  alias_attribute :admin?, :is_admin

  belongs_to :slack_user

  def uid
    slack_user.uid
  end

  class << self
    def find_or_create_with_omniauth(auth)
      SlackUser.update_from_slack_api_repository
      slack_user = SlackUser.find_by(uid: auth['uid'])
      find_by(slack_user: slack_user) || create_with_omniauth(auth, slack_user)
    end

    private

    def create_with_omniauth(auth, slack_user)
      create! do |user|
        user.slack_user = slack_user
        user.is_admin = auth.extra.user_info['user']['is_admin']
      end
    end
  end
end
