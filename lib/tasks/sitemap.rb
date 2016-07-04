namespace :sitemap do
  desc 'Create Sitemap to AWS-S3'
  task create_site_map: :environment do |task|
      success_msgs = []
      success_msgs << 'success'

      batch_start_at = Time.zone.now
      puts "run #{task.name} with env: #{Rails.env} : #{batch_start_at}"
  end
end
