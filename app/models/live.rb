# == Schema Information
#
# Table name: lives
#
#  id                :integer          not null, primary key
#  live_id           :string(255)
#  url               :string(255)
#  title             :string(255)
#  start_time        :datetime
#  icon_url          :string(255)
#  icon_file_name    :string(255)
#  icon_content_type :string(255)
#  icon_file_size    :integer
#  icon_updated_at   :datetime
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#
# Indexes
#
#  index_lives_on_live_id  (live_id)
#

class Live < ApplicationRecord
  validates :live_id, :url, presence: true, uniqueness: true
  validates :title, :start_time, presence: true

  has_attached_file :icon, default_url: '/images/dummy_thumbnail.png'
  validates_attachment_content_type :icon, content_type: %r{/\Aimage\/.*\Z/}

  before_save :fetch_icon

  def fetch_icon
    self.icon = VideoImageDownloadService.fetch_file(icon_url)
    true
  end
end
