module ImperialInfrastructure
  class MatchupDetector
    class << self
      def exec(video_id)
        string_io = open("http://imperial/20/100/#{video_id}", read_timeout: timeout)
        ActiveSupport::JSON.decode(string_io.read)
      rescue
        {}
      end

      private

      def timeout
        7200 if Rails.env.production?
        1 if Rails.env.development?
      end
    end
  end
end
