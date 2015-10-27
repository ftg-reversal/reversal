module Batch
  class UpdateLives
    class << self
      def exec
        lives = LiveApiRepository.find_nicovideo_live.select(&:validate)
        lives.map { |live|live.save }

        Live.all.map do |live|
          live.destroy if live.start_time + 30.minutes < DateTime.now
        end
      end
    end
  end
end
