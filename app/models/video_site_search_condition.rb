# == Schema Information
#
# Table name: video_site_search_conditions
#
#  id         :integer          not null, primary key
#  word       :string(255)      not null
#  video_site :string(255)      not null
#  created_at :datetime
#  updated_at :datetime
#

class VideoSiteSearchCondition < ApplicationRecord
  include ClassyEnum::ActiveRecord

  classy_enum_attr :video_site
end
