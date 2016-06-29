# == Schema Information
#
# Table name: videos
#
#  id                     :integer          not null, primary key
#  url                    :string(255)      not null
#  video_id               :string(255)
#  video_site             :string(255)      not null
#  title                  :string(255)      not null
#  posted_at              :datetime         not null
#  created_at             :datetime
#  updated_at             :datetime
#  thumbnail_file_name    :string(255)
#  thumbnail_content_type :string(255)
#  thumbnail_file_size    :integer
#  thumbnail_updated_at   :datetime
#
# Indexes
#
#  index_videos_on_posted_at   (posted_at)
#  index_videos_on_video_id    (video_id)
#  index_videos_on_video_site  (video_site)
#  url                         (url) UNIQUE
#

class Video < ActiveRecord::Base
  include ClassyEnum::ActiveRecord

  has_many :video_matchups, dependent: :destroy

  validates :video_site, :title, presence: true
  validates :url, presence: true, uniqueness: true

  classy_enum_attr :video_site
  before_save :fetch_thumbnail
  after_save :apply_imperial

  has_attached_file :thumbnail, default_url: '/images/dummy_thumbnail.png'
  validates_attachment_content_type :thumbnail, content_type: %r{/\Aimage\/.*\Z/}

  def fetch_thumbnail
    self.thumbnail = VideoImageDownloadService.fetch_file(thumbnail_uri)
    true
  end

  def apply_imperial
    return true unless title.include?('高田馬場ミカド')

    video_matchups.map(&:destory)
    ImperialRepository.find_all_by_video(self).map do |matchup|
      matchup.video = self
      matchup.save
    end
    true
  end

  # @return [String]
  def thumbnail_uri
    video_site.thumbnail_uri(video_id)
  end
end
