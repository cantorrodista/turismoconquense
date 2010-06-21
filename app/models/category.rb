class Category < ActiveRecord::Base
  include Nicenamed
  validates_length_of :name, :minimum => 3
  has_many :highlight_categories
  has_many :highlights, :through => :highlight_categories
  has_many :tag_categories
  has_many :tags, :through => :tag_categories
  
  named_scope :visible, :conditions => "visible = true"
  
  
  def navigation_tags
    return "" if highlights.blank?
    Tag.find_by_sql("SELECT `tags`.* , count(*) as total FROM `tags` INNER JOIN `taggings` ON `tags`.id = `taggings`.tag_id WHERE ((`taggings`.taggable_type = 'Highlight') AND (`taggings`.taggable_id IN (#{highlights.map(&:id).join(',')})) AND ((taggings.context = 'navigation'))) group by tags.id")
  end
  
  def url
    "cuenca/noticias/categorias/#{nicename}"
  end
end
