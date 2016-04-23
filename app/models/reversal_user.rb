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

  def self.create_with_omniauth(auth, slack_user)
    create! do |user|
      user.slack_user = slack_user
      user.is_admin = auth.extra.user_info['user']['is_admin']
    end
  end

  def to_param
    slack_user.name
  end
end
