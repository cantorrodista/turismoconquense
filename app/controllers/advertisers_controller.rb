class AdvertisersController < InheritedResources::Base
  defaults :resource_class => Advertiser, :collection_name => 'advertisers', :instance_name => 'advertiser'
  before_filter :require_session, :except => [:show]
  respond_to :html
  include NicenamedResource

  def create
      create! do |success, failure|
        success.html do
          flash[:notice] = t("flash.advertisers.create.notice")
          redirect_to advertisers_path
        end
        failure.html do
          flash[:notice] = t("flash.advertisers.create.error")
          render :action => :new
        end
      end
  end

  def update
    update!  do |success, failure|
      success.html do
        flash[:notice] = t("flash.advertisers.update.notice")
        redirect_to edit_advertiser_path(@advertiser)
      end
      failure.html do
        flash[:notice] = t("flash.advertisers.update.error")
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
    @advertisers ||= end_of_association_chain.paginate(:page => params[:page], :per_page => 20)
  end

end

