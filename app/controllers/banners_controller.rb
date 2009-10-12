class BannersController < InheritedResources::Base
    actions :index, :show, :edit, :update
    respond_to :html
    before_filter :require_session, :except => [:show]
    
end
