class ImperialRepository
  def self.find_all_by_video(video)
    ImperialInfrastructure::MatchupDetector.exec(video.video_id).map do |hash|
      VideoMatchup.new(
        video: video,
        chara1: Chara.find_by(en_name: hash['1p']),
        chara2: Chara.find_by(en_name: hash['2p']),
        sec: hash['sec'].to_i
      )
    end
  end
end
