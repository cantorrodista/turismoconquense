class Category < ActiveRecord::Base
  include Nicenamed
  validates_length_of :name, :minimum => 3
  has_many :highlight_categories
  has_many :highlights, :through => :highlight_categories
  
  named_scope :visible, :conditions => "visible = true"
  
  
  def navigation_tags
    return "" if highlights.blank?
    Category.find_by_sql("SELECT `tags`.* FROM `tags` INNER JOIN `taggings` ON `tags`.id = `taggings`.tag_id WHERE ((`taggings`.taggable_type = 'Highlight') AND (`taggings`.taggable_id IN (#{highlights.map(&:id).join(',')})) AND ((taggings.context = 'navigation')))")
  end
end
