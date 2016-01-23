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
  has_many :slack_message
end
