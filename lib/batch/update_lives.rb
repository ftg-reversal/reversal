module Batch
  class UpdateLives
    class << self
      def exec
        lives = LiveApiRepository.find_nicovideo_live.select(&:validate)
        lives.map(&:save)

        Live.all.map do |live|
          live.destroy if live.start_time + 30.minutes < Time.zone.now.to_datetime
        end
      end
    end
  end
end
