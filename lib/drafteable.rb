module Drafteable
  def self.included(base)
    base.extend DrafteableClassMethods
  end
end

module DrafteableClassMethods
  def drafts(order_by = 'name ASC')
    find(:all, :order => order_by, :conditions => ['published = ?', false])
  end
  
  def published(order_by = 'created_at ASC')
    find(:all, :order => order_by, :conditions => ['published = ?', true])
  end
end

module DrafteableResource
  #include NicenamedResource

  def self.included(base)
    base.class_eval do
      respond_to :html
      respond_to :js, :only => [:update]
  
      before_filter :require_admin, :only => [:new, :create, :edit, :update, :destroy]
      before_filter :parse_form, :only => [:create, :update]
      before_filter :require_admin_or_published, :only => :show
    end
    table_name = base.name[0..-11].tableize # posts, projects, ...
    # p.e:
    # def collection
    #   @posts ||= end_of_association_chain.paginate(:page => params[:page])
    # end 
    base.class_eval <<-"end_eval", __FILE__, __LINE__
      private
        def collection
          @#{table_name} ||= end_of_association_chain.paginate(:page => params[:page], 
            :per_page => Settings.#{table_name}.per_page, :order => 'date DESC', 
            :conditions => ['published = ?', true])
        end
    end_eval
  end
  
  def create
    create! do |success, failure|
      success_html(success, :create)
    end
  end

  def update
    update!  do |success, failure|
      success_html(success, :update)
      success.js do
        flash[:notice] = nil # problemilla con inherited resources
        render :text => resource.to_json(:only => (params[resource_sym].keys << :id))
      end
      failure.js do
        headers["Content-Type"] = "text/html; charset=utf-8"
        render :text => {:error => resource.errors.full_messages.to_sentence}.to_json, 
               :status => '406'
      end
    end
  end

  private
    def parse_form
      params[resource_sym][:published] = true if params[resource_sym][:published]
    end
    
    def success_html(success, action)
      success.html do
        if resource.published?
          flash[:notice] = t "flash.#{table_name}.#{action}.notice_published"
        else
          flash[:notice] = t "flash.#{table_name}.#{action}.notice_draft"
        end
        redirect_to eval("edit_#{resource_name}_path(resource)")
      end
    end
    
    def require_admin_or_published
      if resource
        return require_admin unless resource.published?
      else
        render_client_error(:code => 404)
        return false
      end
    end

    def resource_model_name
      self.class.name[0..-11]  # PostsController - Controller = Posts
    end

    def resource_model
      eval(resource_model_name.singularize)
    end

    def table_name
      resource_model_name.tableize
    end

    def resource_name
      table_name.singularize
    end

    def resource_sym
      resource_name.to_sym
    end
end
