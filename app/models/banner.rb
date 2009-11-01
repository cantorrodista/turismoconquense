class Banner < ActiveRecord::Base

  belongs_to :advertiser
  
  named_scope :by_location, lambda { |block| 
    {:conditions => " location = '#{block}' AND active = 1", :order => :position}
   }
   
  has_attached_file :image, :default_style => :medium,:default_url => "",
  
  :path => ":rails_root/" + (RAILS_ENV == 'test'? 'tmp/' : '') + "public" +
  "/system/:class/:attachment/:id/:style_:basename.:extension",
  :url =>  "/system/:class/:attachment/:id/:style_:basename.:extension",
  :styles => {
    :sidebar => [Settings.banner.image.sidebar, :jpg],
    :body => [Settings.banner.image.body, :jpg],
    :body_medium => [Settings.banner.image.body_medium, :jpg]
  }
  
  before_create :set_width
  
  validates_presence_of :title, :location
  
  def is_active?
    return true if self.active
  end
  
  private
  
  def set_width
    self.width = case self.location
    when "Top" 
      670
    when "Bottom"
      470
    else
      180
    end
  end
end

