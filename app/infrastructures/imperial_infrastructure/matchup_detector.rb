require 'json'

module ImperialInfrastructure
  class MatchupDetector
    class << self
      def exec(video_id)
        string_io = open("http://imperial/80/100/#{video_id}", read_timeout: 4000)
        JSON.parse(string_io.read)
      rescue
        {}
      end
    end
  end
end
