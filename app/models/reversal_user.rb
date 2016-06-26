# == Schema Information
#
# Table name: reversal_users
#
#  id              :integer          not null, primary key
#  slack_user_id   :integer
#  is_admin        :boolean
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  twitter_user_id :integer
#
# Indexes
#
#  index_reversal_users_on_twitter_user_id  (twitter_user_id) UNIQUE
#  slack_user_id                            (slack_user_id) UNIQUE
#

class ReversalUser < ActiveRecord::Base
  alias_attribute :admin?, :is_admin

  belongs_to :slack_user
  belongs_to :twitter_user

  def icon_url
    if slack_user
      slack_user.icon_url
    elsif twitter_user
      twitter_user.icon_url
    end
  end

  def name
    if slack_user
      slack_user.name
    elsif twitter_user
      twitter_user.name
    end
  end

  class << self
    def find_or_create_with_slack(auth)
      SlackUser.update_from_slack_api_repository
      slack_user = SlackUser.find_by(uid: auth['uid'])
      find_by(slack_user: slack_user) || create_with_slack(auth, slack_user)
    end

    def find_or_create_with_twitter(auth)
      twitter_user = TwitterUser.find_by(uid: auth['uid']) || TwitterUser.create_with_omniauth(auth)
      find_by(twitter_user: twitter_user) || create_with_twitter(twitter_user)
    end

    private

    def create_with_slack(auth, slack_user)
      create! do |user|
        user.slack_user = slack_user
        user.is_admin = auth.extra.user_info['user']['is_admin']
      end
    end

    def create_with_twitter(twitter_user)
      create! do |user|
        user.twitter_user = twitter_user
        user.is_admin = false
      end
    end
  end
end
