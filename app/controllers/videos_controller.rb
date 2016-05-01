# == Schema Information
#
# Table name: videos
#
#  id                     :integer          not null, primary key
#  url                    :string(255)      default(""), not null
#  video_id               :string(255)
#  video_site             :string(255)      not null
#  title                  :string(255)      default(""), not null
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
#  index_videos_on_video_id  (video_id)
#  url                       (url) UNIQUE
#

class VideosController < ApplicationController
  def index
    @videos = Video.order('posted_at DESC').page(params[:page])
  end
end
