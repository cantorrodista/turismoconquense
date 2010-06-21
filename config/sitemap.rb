# Set the host name for URL creation
SitemapGenerator::Sitemap.default_host = "http://turismoconquense.com"

SitemapGenerator::Sitemap.add_links do |sitemap|
  # Put links creation logic here.
  #
  # The root path '/' and sitemap index file are added automatically.
  # Links are added to the Sitemap in the order they are specified.
  #
  # Usage: sitemap.add path, options
  #        (default options are used if you don't specify)
  #
  # Defaults: :priority => 0.5, :changefreq => 'weekly',
  #           :lastmod => Time.now, :host => default_host


    Category.find(:all).each do |p|
      sitemap.add p.url,:lastmod => p.updated_at, :priority => 0.7
    end
    Highlight.find(:all).each do |p|
      sitemap.add p.url,:lastmod => p.updated_at, :priority => 0.7
    end



end

