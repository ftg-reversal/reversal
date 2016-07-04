# Set the host name for URL creation
SitemapGenerator::Sitemap.default_host = 'http://ftg-reversal.net/' # ホスト名
SitemapGenerator::Sitemap.sitemaps_path = 'sitemaps/'

SitemapGenerator::Sitemap.create do
  current_time = Time.zone.now

  # トップ画面
  add root_path, lastmod: current_time, changefreq: 'daily', priority: 1.0

  # 静的ページ
  static_page_options = { lastmod: current_time, changefreq: 'monthly', priority: 0.5 }
  add(sign_in_path, static_page_options)
  add(sign_up_path, static_page_options)
  add(policy_path, static_page_options)
  add(guide_path, static_page_options)
  add(faq_path, static_page_options)

  # 動的ページ
  dynamic_page_options = { changefreq: 'weekly', priority: 0.75 }
end
