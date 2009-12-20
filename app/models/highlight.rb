class Highlight < ActiveRecord::Base
  include Nicenamed
  has_many :highlight_categories
  has_many :categories, :through => :highlight_categories
  #has_many :tags, :through => :highlight_tags
  #has_many :comments, :as => :commentable, :dependent => :destroy, 
   # :order => 'created_at ASC'
  
  #acts_as_rated :rating_range => 1..5
  acts_as_polymorphic_paperclip :styles => Settings.highlight.assets.styles

  validates_length_of :name, :minimum => 3
  #validates_presence_of :summary, :if => :published?
  validates_presence_of :body, :if => :published?
  validates_presence_of :categories, :if => :published?
  
  named_scope :drafts,:conditions => ['published = ?', false], :order => 'created_at DESC'
  named_scope :published,:conditions => ['published = ?', true], :order => 'created_at DESC'
  named_scope :main_featured,:conditions => ['main_featured = ?', true], :limit => 1
  named_scope :featured,:conditions => ['featured = ?', true],:order => 'created_at DESC', :limit => 10
  
  def is_event?
    self.categories.include?(Category.find_by_nicename('eventos'))
  end
end
