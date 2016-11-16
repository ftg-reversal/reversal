every 3.minutes, roles: [:batch] do
  runner 'OnlineBotBatch.exec'
end

every 5.minutes, roles: [:batch] do
  runner 'Twitter2slackBatch.exec'
  runner 'UpdateSlackBatch.exec'
  runner 'UpdateLivesBatch.exec'
end

every 15.minutes, roles: [:batch] do
  runner 'UpdateVideosBatch.exec'
end

# every 3.hours do
#   runner 'TwitterAdsBatch.exec'
# end

every 6.hours, roles: [:batch] do
  rake 'db:backup'
end

# ミカド天下一武道会
every 1.day, at: '00:00 am', roles: [:batch] do
  runner 'MikadoTenkaichiResetBatch.exec'
end

# sitemap
every 1.day, at: '10:00 am', roles: [:batch] do
  rake 'sitemap:refresh'
end
