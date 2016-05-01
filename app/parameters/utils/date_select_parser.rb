module Utils
  class DateSelectParser
    def self.exec(params, key)
      date_parts = params.select { |k, _| k.to_s =~ /\A#{key}\([1-6]{1}i\)/ }.values
      date_str = date_parts[0..2].join('-') + ' ' + date_parts[3..-1].join(':')
      Time.zone.parse(date_str).to_datetime
    end
  end
end
