class Highlight < ActiveRecord::Base
  include Nicenamed
  has_many :highlight_categories
  has_many :categories, :through => :highlight_categories

  #acts_as_rated :rating_range => 1..5
  acts_as_polymorphic_paperclip :styles => Settings.highlight.assets.styles
  acts_as_taggable_on :tags, :navigation
  has_many :comments, :as => :commentable, :dependent => :destroy, 
    :order => 'created_at ASC'
  
  validates_length_of :name, :minimum => 3
  validates_presence_of :body, :if => :published?
  validates_presence_of :categories, :if => :published?
  
  named_scope :drafts,:conditions => ['published = ?', false], :order => 'created_at DESC'
  named_scope :published,:conditions => ['published = ?', true], :order => 'created_at DESC'
  named_scope :main_featured,:conditions => ['main_featured = ?', true], :limit => 1
  named_scope :featured,:conditions => ['featured = ?', true],:order => 'created_at DESC', :limit => 10
  acts_as_rated :rating_range => 1..5
  
  def is_event?
    self.categories.include?(Category.find_by_nicename('eventos'))
  end
  
  def rating_average_pct
    (rating_average || 0 ) * 100 / 5.0
  end
end
