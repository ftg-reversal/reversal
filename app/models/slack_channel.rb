# == Schema Information
#
# Table name: slack_channels
#
#  id          :integer          not null, primary key
#  cid         :string(255)
#  name        :string(255)
#  topic       :string(255)
#  is_archived :boolean
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
# Indexes
#
#  cid  (cid) UNIQUE
#

class SlackChannel < ActiveRecord::Base
  has_many :slack_message, -> { order(ts: 'desc') }
end
