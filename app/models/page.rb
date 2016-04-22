# == Schema Information
#
# Table name: pages
#
#  id               :integer          not null, primary key
#  title            :string(255)      not null
#  description      :text(65535)      not null
#  reversal_user_id :integer          not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
# Indexes
#
#  index_pages_on_reversal_user_id  (reversal_user_id)
#

class Page < ActiveRecord::Base
  belongs_to :reversal_user

  validates :title, presence: true
  validates :description, presence: true
  validates :reversal_user_id, presence: true
end
