every 5.minutes do
  runner 'Batch::Twitter2slack.exec'
  runner 'Batch::UpdateSlack.exec'
  runner 'Batch::UpdateLives.exec'
end

every 15.minutes do
  runner 'Batch::UpdateVideos.exec'
end

every 3.hours do
  runner 'Batch::TwitterAds.exec'
end

every 6.hours do
  rake 'db:backup'
end
