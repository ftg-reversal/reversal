module TimeHelper
  def sec_to_time(sec)
    "#{(sec / 60)} : #{sec % 60}"
  end
end
