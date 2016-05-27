# == Schema Information
#
# Table name: video_matchups
#
#  id        :integer          not null, primary key
#  video_id  :integer
#  chara1_id :integer
#  chara2_id :integer
#  sec       :integer
#
# Indexes
#
#  fk_rails_238a2e45c9  (chara1_id)
#  fk_rails_689c62c943  (chara2_id)
#  fk_rails_b3ee212891  (video_id)
#

class VideoMatchup < ActiveRecord::Base
  belongs_to :video
  belongs_to :chara1, class_name: 'Chara'
  belongs_to :chara2, class_name: 'Chara'
end
