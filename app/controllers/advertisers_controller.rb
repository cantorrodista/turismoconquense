class AdvertisersController < InheritedResources::Base
  respond_to :html
  before_filter :require_session, :except => [:show]

end
