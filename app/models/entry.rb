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
# Indexes
#
#  fk_rails_20eb5df311        (event_id)
#  fk_rails_6a9722b611        (reversal_user_id)
#  fk_rails_8580cf0bd4        (twitter_user_id)
#  index_entries_on_chara_id  (chara_id)
#  index_entries_on_rank_id   (rank_id)
#

class Entry < ActiveRecord::Base
  belongs_to :event
  belongs_to :chara
  belongs_to :rank
  belongs_to :reversal_user
  belongs_to :twitter_user

  validates :name, presence: true
  validates :chara, presence: true
  validates :rank, presence: true
  validates :event, presence: true

  scope :including_all, -> () { includes(:chara).includes(:rank).includes(:reversal_user).includes(:twitter_user) }

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
