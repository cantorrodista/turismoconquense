class HighlightsController < InheritedResources::Base
  defaults :resource_class => Highlight, :collection_name => 'highlights', :instance_name => 'highlight'
  respond_to :html
  before_filter :require_session, :except => [:index,:show]
  include NicenamedResource
  before_filter :parse_form, :only => [:create, :update]
  before_filter :require_admin_or_published, :only => :show
  
  def index
    index! do |success, failure|
      success.html do
        render :template => logged_in? ? "highlights/index" : "highlights/public_index"
      end
    end
  end 
  
  def create
      create! do |success, failure|
        success.html do
          flash[:notice] = t("flash.highlights.create.notice")
          redirect_to highlights_path
        end
        failure.html do
          flash[:notice] = t("flash.highlights.create.error")
          render :action => :new
        end
      end
  end

  def update
    update!  do |success, failure|
      success.html do
        flash[:notice] = t("flash.highlights.update.notice")
        redirect_to edit_highlight_path(@highlight)
      end
      failure.html do
        flash[:notice] = t("flash.highlights.update.error")
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
 
 def detach
   asset = Asset.find(params[:asset_id])
   if asset && resource.assets.include?(asset)
     resource.assets.detach(asset.id,true)
   end
   flash[:notice] = I18n.t("flash.general.destroy.notice")
   redirect_to request.env['HTTP_REFERER']
 end

  
private
  
  def collection    
    @highlights ||= if params[:category] and
         @category = Category.find_by_nicename(params[:category])
        end_of_association_chain.paginate(:page => params[:page],
        :per_page => 10, :order => 'date DESC',
        :include => [:highlight_categories],
        :conditions => ['highlights.published = ? and highlight_categories.category_id = ?', true, @category.id])
      else
        end_of_association_chain.paginate(:page => params[:page], 
          :per_page => 10, :order => 'date DESC')
      end
  end
  
  def parse_form
    params[:highlight][:published] = params[:highlight][:published] ? true : false
  end

  def require_admin_or_published
    if resource
      return require_admin unless resource.published?
    else
      render_error(:code => 404)
      return false
    end
  end


end
