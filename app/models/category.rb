class Category < ActiveRecord::Base
  include Nicenamed
  validates_length_of :name, :minimum => 3
end
