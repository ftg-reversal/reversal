# Set the host name for URL creation
SitemapGenerator::Sitemap.default_host = 'http://ftg-reversal.net/' # ホスト名
SitemapGenerator::Sitemap.sitemaps_path = 'sitemaps/'

SitemapGenerator::Sitemap.create do
  current_time = Time.zone.now

  add root_path, lastmod: current_time, changefreq: 'daily', priority: 1.0
  add videos_path, priority: 0.7, changefreq: 'daily'
  add rlogs_path, priority: 0.7, changefreq: 'daily'
  add pages_path, priority: 0.7, changefreq: 'daily'
  add summaries_path, priority: 0.7, changefreq: 'daily'
end
