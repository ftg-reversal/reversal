module TimeHelper
  def sec_to_time(sec)
    "#{(sec / 60)} : #{format('%02d', (sec % 60))}"
  end
end
