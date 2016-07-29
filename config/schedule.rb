every 3.minutes do
  runner 'OnlineBotBatch.exec'
end

every 5.minutes do
  runner 'Twitter2slackBatch.exec'
  runner 'UpdateSlackBatch.exec'
  runner 'UpdateLivesBatch.exec'
end

every 15.minutes do
  runner 'UpdateVideosBatch.exec'
end

# every 3.hours do
#   runner 'TwitterAdsBatch.exec'
# end

every 6.hours do
  rake 'db:backup'
end

# sitemap
if @environment.to_sym == :production
  every 1.day, at: '10:00 am' do
    rake 'sitemap:refresh'
  end
end
