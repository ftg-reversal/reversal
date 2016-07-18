# == Schema Information
#
# Table name: reversal_users
#
#  id              :integer          not null, primary key
#  twitter_user_id :integer
#  slack_user_id   :integer
#  is_admin        :boolean          default(FALSE)
#  screen_name     :string(255)
#  name            :string(255)
#  chara_id        :integer
#  rank_id         :integer
#  home            :text(65535)
#  bio             :text(65535)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
# Indexes
#
#  index_reversal_users_on_chara_id         (chara_id)
#  index_reversal_users_on_rank_id          (rank_id)
#  index_reversal_users_on_screen_name      (screen_name)
#  index_reversal_users_on_twitter_user_id  (twitter_user_id) UNIQUE
#  slack_user_id                            (slack_user_id) UNIQUE
#

class ReversalUser < ApplicationRecord
  alias_attribute :admin?, :is_admin

  belongs_to :slack_user
  belongs_to :twitter_user
  belongs_to :chara
  belongs_to :rank

  scope :including_user, -> () { includes(:twitter_user).includes(:slack_user) }

  include PublicActivity::Model

  def icon_url
    if slack_user
      slack_user.icon_url
    elsif twitter_user
      "http://furyu.nazo.cc/twicon/#{screen_name}/original"
    end
  end

  class << self
    def find_or_create_with_slack(auth)
      SlackUser.update_from_slack_api_repository
      slack_user = SlackUser.find_by(uid: auth['uid'])
      find_by(slack_user: slack_user) || create_with_slack(auth, slack_user)
    end

    def find_or_create_with_twitter(auth)
      twitter_user = TwitterUser.find_by(uid: auth['uid'])
      if twitter_user
        twitter_user.update_with_omniauth(auth)
        twitter_user.reload
      else
        twitter_user = TwitterUser.create_with_omniauth(auth)
      end
      find_by(twitter_user: twitter_user) || create_with_twitter(twitter_user, auth)
    end

    private

    # rubocop:disable Metrics/MethodLength
    def create_with_slack(auth, slack_user)
      create! do |user|
        user.slack_user = slack_user
        user.screen_name = slack_user.name
        user.is_admin = auth.extra.user_info['user']['is_admin']
      end
    rescue
      create! do |user|
        user.slack_user = slack_user
        user.screen_name = "slack-#{slack_user.name}"
        user.is_admin = auth.extra.user_info['user']['is_admin']
      end
    end
    # rubocop:enable Metrics/MethodLength

    def create_with_twitter(twitter_user, auth)
      create! do |user|
        user.twitter_user = twitter_user
        user.screen_name = twitter_user.screen_name
        user.bio = auth['info']['description']
        user.is_admin = false
      end
    end
  end
end
