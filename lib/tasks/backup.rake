namespace :db do  desc 'Backup database to AWS-S3'
  task :backup => [:environment] do
    datestamp = Time.now.strftime('%Y-%m-%d_%H-%M-%S')
    backup_filename = "#{Rails.root.basename}-#{datestamp}.sql"
    db_config = ActiveRecord::Base.configurations[Rails.env]

    # process backup
    `mysqldump -h #{db_config['host']} -u #{db_config['username']} -p#{db_config['password']} -i -c -q #{db_config['database']} > tmp/#{backup_filename}`
    `gzip -9 tmp/#{backup_filename}`
    puts "Created backup: #{backup_filename}"

    # save to aws-s3
    Aws.config[:region] = 'ap-northeast-1'
    bucket_name = "reversal-#{Rails.env}-database-backup"
    s3_client = Aws::S3::Client.new

    unless s3_client.list_buckets.buckets.map(&:name).include?(bucket_name)
      s3_client.create_bucket(bucket: bucket_name, acl: 'private')
    end

    s3_client.put_object(bucket: bucket_name, body: File.open("tmp/#{backup_filename}.gz"), key: File.basename("#{backup_filename}.gz"))

    # remove local backup file
    `rm -f tmp/#{backup_filename}.gz`
  end
end
