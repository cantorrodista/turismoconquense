class BannersController < InheritedResources::Base
    
    defaults :resource_class => Banner, :collection_name => 'banners', :instance_name => 'banner'
    respond_to :html
    before_filter :require_session, :except => [:show]
    
    def create
        create! do |success, failure|
          success.html do
            flash[:notice] = t("flash.banners.create.notice")
            redirect_to banners_path
          end
          failure.html do
            flash[:notice] = t("flash.banners.create.error")
            render :action => :new
          end
        end
    end

    def update
      update!  do |success, failure|
        success.html do
          flash[:notice] = t("flash.banners.update.notice")
          redirect_to edit_banner_path(@banner)
        end
        failure.html do
          flash[:notice] = t("flash.banners.update.error")
          render :action => :edit
        end
      end
    end
    
    def delete
      resource_class.destroy(params[:ids])
      respond_to do |wants|
        wants.html { 
          flash[:notice] = I18n.t("flash.general.destroy.notice", :count => params[:ids].size)
            redirect_to :action => :index 
        }
      end
   end
  
    
  private
    
    def collection
      @banners ||= end_of_association_chain.paginate(:page => params[:page], :per_page => 20)
    end
end

