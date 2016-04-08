# == Schema Information
#
# Table name: entries
#
#  id               :integer          not null, primary key
#  name             :string(255)
#  chara_id         :integer
#  rank_id          :integer
#  comment          :text(65535)
#  event_id         :integer
#  reversal_user_id :integer
#  twitter_user_id  :integer
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

class Entry < ActiveRecord::Base
  belongs_to :event
  belongs_to :chara
  belongs_to :rank
  belongs_to :reversal_user
  belongs_to :twitter_user

  def self.find_by_user(user)
    if user.class == ReversalUser
      find_by(reversal_user: user)
    elsif user.class == TwitterUser
      find_by(twitter_user: user)
    end
  end

  def user
    reversal_user || twitter_user
  end
end
