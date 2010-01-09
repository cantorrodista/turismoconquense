class CategoriesController < InheritedResources::Base
  defaults :resource_class => Category, :collection_name => 'categories', :instance_name => 'category'
  respond_to :html
  before_filter :require_session, :except => :index
  include NicenamedResource
  
  
  def index
    if logged_in?
      index!
    else
      @categories = Category.visible
      render 'public_index'
    end
  end
  def create
      create! do |success, failure|
        success.html do
          flash[:notice] = t("flash.categories.create.notice")
          redirect_to categories_path
        end
        failure.html do
          flash[:notice] = t("flash.categories.create.error")
          render :action => :new
        end
      end
  end

  def update
    update!  do |success, failure|
      success.html do
        flash[:notice] = t("flash.categories.update.notice")
        redirect_to categories_path
      end
      failure.html do
        flash[:notice] = t("flash.categories.update.error")
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
    @categories ||= end_of_association_chain.paginate(:page => params[:page], :per_page => 20)
  end
end
