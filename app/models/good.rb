# == Schema Information
#
# Table name: goods
#
#  id               :integer          not null, primary key
#  reversal_user_id :integer          not null
#  goodable_id      :integer
#  goodable_type    :string(255)
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
# Indexes
#
#  index_goods_on_goodable_id_and_goodable_type  (goodable_id,goodable_type)
#  index_goods_on_id_and_type                    (reversal_user_id,goodable_id,goodable_type) UNIQUE
#  index_goods_on_reversal_user_id               (reversal_user_id)
#

class Good < ActiveRecord::Base
  belongs_to :goodable, polymorphic: true
  belongs_to :reversal_user

  validates :reversal_user, presence: true
  validates :reversal_user, uniqueness: { scope: [:goodable_id, :goodable_type] }

  scope :user, -> (user) { where(reversal_user: user) }
  scope :type, -> (type) { where(goodable_type: type) }
  scope :id,   -> (id)   { where(goodable_id: id) }
end
