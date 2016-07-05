# == Schema Information
#
# Table name: video_matchups
#
#  id        :integer          not null, primary key
#  video_id  :integer          not null
#  chara1_id :integer          not null
#  chara2_id :integer          not null
#  sec       :integer          not null
#
# Indexes
#
#  index_video_matchups_on_chara1_id  (chara1_id)
#  index_video_matchups_on_chara2_id  (chara2_id)
#  index_video_matchups_on_video_id   (video_id)
#

class VideoMatchup < ActiveRecord::Base
  belongs_to :video
  counter_culture :video

  belongs_to :chara1, class_name: 'Chara'
  belongs_to :chara2, class_name: 'Chara'
end
