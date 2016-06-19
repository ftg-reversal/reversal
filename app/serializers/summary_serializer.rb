# == Schema Information
#
# Table name: rlogs
#
#  id               :integer          not null, primary key
#  title            :string(255)      not null
#  description      :text(65535)
#  slack_channel_id :integer
#  reversal_user_id :integer          not null
#  type             :string(255)      not null
#  created_at       :datetime
#  updated_at       :datetime
#
# Indexes
#
#  fk_rails_9daab45809              (slack_channel_id)
#  index_rlogs_on_reversal_user_id  (reversal_user_id)
#  index_rlogs_on_type              (type)
#

class SummarySerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :user, :path

  def user
    object.reversal_user_id
  end

  def path
    scope.summary_path(object)
  end
end
