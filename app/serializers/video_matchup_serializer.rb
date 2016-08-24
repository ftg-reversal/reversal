class VideoMatchupSerializer < ActiveModel::Serializer
  attributes :id, :video_id, :chara1_id, :chara2_id, :sec
end
