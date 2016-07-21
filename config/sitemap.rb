SitemapGenerator::Sitemap.default_host = 'http://ftg-reversal.net/'
SitemapGenerator::Sitemap.sitemaps_path = 'sitemaps/'

SitemapGenerator::Sitemap.adapter = SitemapGenerator::S3Adapter.new(fog_provider: 'AWS',
                                                                    aws_access_key_id: ENV['AWS_ACCESS_KEY_ID'],
                                                                    aws_secret_access_key: ENV['AWS_SECRET_ACCESS_KEY'],
                                                                    fog_directory: 'reversal-sitemap',
                                                                    fog_region: 'ap-northeast-1'
                                                                   )

SitemapGenerator::Sitemap.create do
  current_time = Time.zone.now

  add root_path,      lastmod: current_time, changefreq: 'daily', priority: 1.0

  add videos_path,    priority: 0.7, changefreq: 'daily'
  add rlogs_path,     priority: 0.7, changefreq: 'daily'
  add pages_path,     priority: 0.7, changefreq: 'daily'
  add summaries_path, priority: 0.7, changefreq: 'daily'
  add events_path,    priority: 0.7, changefreq: 'daily'
  add users_path,     priority: 0.5, changefreq: 'weekly'

  Page.find_each do |page|
    add page_path(page), lastmod: page.updated_at
  end
  Summary.find_each do |summary|
    add summary_path(summary), lastmod: summary.updated_at
  end
  Page.find_each do |event|
    add event_path(event), lastmod: event.updated_at
  end
  ReversalUser.find_each do |user|
    add user_path(user.screen_name), lastmod: user.updated_at
  end
end
