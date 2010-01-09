class CommentsController < InheritedResources::Base
  defaults :resource_class => Comment, :collection_name => 'comments', :instance_name => 'comment'
  respond_to :html, :only => [:create, :index]
  before_filter :require_session, :only => [:index, :destroy, :update]
  before_filter :require_commentable_params, :only => :create
  helper_method :comment_published?
  
  def create
    @comment = comment_ip_params(Comment)
       create! do |success, failure|
        success.html {
          if Settings.comments.activate_moderation == 1
            #Notifications.deliver_new_comment(@comment) 
            flash[:notice] = t('flash.comments.create.notice_with_moderation')
          end
          redirect_to url_for(@commentable) + '#comments_box'
        }
        failure.html do
          flash[:new_comment_errors] = '<ul><li>' + 
            @comment.errors.full_messages.join('</li><li>') + '</li></ul>'
          flash[:comment] = @comment
          redirect_to url_for(@commentable) + '#new_comment'
        end
      end
  end
  
  def update
    if resource
      resource.update_attribute(:published, params[:unpublish] ? false : true)
      flash[:notice] = params[:unpublish] ? t('flash.comments.unpublished.notice')  : t('flash.comments.published.notice')
      redirect_to comments_path
    end
  end
  
  private
    def collection
      @comments ||= if params[:q] == 'published'
      end_of_association_chain.paginate(:page => params[:page],
        :conditions =>  ['published = ?',true], :order => 'created_at DESC',
        :per_page => Settings.comments.per_page)
      else
        end_of_association_chain.paginate(:page => params[:page],
          :conditions =>  ['published = ?',false], :order => 'created_at DESC',
          :per_page => Settings.comments.per_page)
      end
    end
  
    def require_commentable_params
      unless (@commentable = polymorph_parent(params[:comment], :commentable)) &&
             !@commentable.closed?
        render_error(:code => 400)
        return false
      end
    end
  protected
      def comment_published?
        params[:q] == 'published'
      end
      
     
end
