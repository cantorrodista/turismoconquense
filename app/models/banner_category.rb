class BannerCategory < ActiveRecord::Base
  belongs_to :banner
  belongs_to :category
end