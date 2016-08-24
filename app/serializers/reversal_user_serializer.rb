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

class ReversalUserSerializer < ActiveModel::Serializer
  attributes :id, :screen_name, :name
end
