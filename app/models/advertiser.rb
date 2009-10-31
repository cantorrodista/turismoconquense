class Advertiser < ActiveRecord::Base
  
  has_many :bannerss, :class_name => "banners"
  has_attached_file :logo, :default_style => :medium,
    :path => ":rails_root/" + (RAILS_ENV == 'test'? 'tmp/' : '') + "public" +
             "/system/:class/:attachment/:id/:style_:basename.:extension",
    :url =>  "/system/:class/:attachment/:id/:style_:basename.:extension",
    :styles => {

      :small => [Settings.advertiser.logo.small_size, :jpg],
      :medium => [Settings.advertiser.logo.medium_size, :jpg],
      :big => [Settings.advertiser.logo.big_size, :jpg]
    }


    validates_presence_of :name,:description

    validates_attachment_content_type :logo,
        :content_type =>  ['image/jpg', 'image/jpeg', 'image/pjpeg',
                           'image/gif', 'image/png', 'image/x-png'],
        :message => I18n.translate('app.advertiser.logo.only_images')

    validates_attachment_size :logo,
        :less_than => 10.megabyte,
        :message => I18n.translate('app.advertiser.logo.max_size')

end

