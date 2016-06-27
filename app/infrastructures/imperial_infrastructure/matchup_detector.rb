require 'json'

module ImperialInfrastructure
  class MatchupDetector
    class << self
      def exec(video_id)
        string_io = open("http://imperial/20/100/#{video_id}", read_timeout: 7200)
        JSON.parse(string_io.read)
      rescue
        {}
      end
    end
  end
end
