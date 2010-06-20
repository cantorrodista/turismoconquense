require 'htmlentities'
require "open-uri"
namespace :feedsucker do
  desc "Suck (fetch & load) every FeedsuckerFeed source stored at DB"
  task :suck_all => :environment do
    FeedsuckerFeed.suck_all!
    coder = HTMLEntities.new
    FeedsuckerPost.scoped_by_processed(false).each do |post|
        
      if post.content
        feed = FeedsuckerFeed.find(post.feedsucker_feed_id)
        category = Category.find_by_nicename(feed.nicetitle)
        highlight = Highlight.find_or_create_by_name(:source_url => post.url, :source_name => Highlight.get_source(post.url),:name => post.title, :body => coder.decode(post.content), :published => true, :date => post.date, :categories => [category])
        begin
          if highlight.body.match(/<\s*img [^\>]*src\s*=\s*["\'](.*?)\s*["\']/)
           remote_file = RemoteFile.new($1)
            highlight.assets.create(:data => remote_file)
          end
          
        rescue Exception => e
          puts e
        end        
        highlight.update_attribute(:body,highlight.body.gsub("Leer más","")) if !highlight.body.blank?
        highlight.update_attribute(:body,highlight.body.gsub("Leer mas","")) if !highlight.body.blank?
        
      end
      post.update_attribute(:processed, true)
    end
    Highlight.published.each{|a| a.update_attribute(:main_featured, false)}
    Highlight.published.each{|a| a.update_attribute(:featured, false)}
    
    Highlight.last_hour.first.update_attribute(:main_featured, true)
    Highlight.published[1..10].each do |a|
     a.update_attribute(:featured, true)
    end
    
  end
end
