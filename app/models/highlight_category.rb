class HighlightCategory < ActiveRecord::Base
  belongs_to :highlight
  belongs_to :category
end
