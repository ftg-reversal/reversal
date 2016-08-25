module ImperialInfrastructure
  class MatchupDetector
    class << self
      def exec(video_id)
        string_io = open("http://imperial/20/100/#{video_id}", read_timeout: timeout)
        ActiveSupport::JSON.decode(string_io.read)
      rescue
        []
      end

      private

      def timeout
        if Rails.env.production?
          7200
        else
          0.1
        end
      end
    end
  end
end
