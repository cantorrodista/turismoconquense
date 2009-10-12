class ApplicationController < ActionController::Base
  helper_method :current_user_session, :current_user, :logged_in?
  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  # Scrub sensitive parameters from your log
  filter_parameter_logging :password

  private

    def current_user_session
      return @current_user_session if defined?(@current_user_session)
      @current_user_session = UserSession.find
    end

    def current_user
      return @current_user if defined?(@current_user)
      @current_user = current_user_session && current_user_session.user
    end

    def logged_in?
      !!current_user
    end

    def require_session
      if current_user
        return true
      else
        store_location
        flash[:notice] = t('app.site.logged_in_only')
        redirect_to new_user_session_url
        return false
      end
    end

    def require_no_session
      if current_user
        flash[:notice] = t('app.site.logged_out_only')
        redirect_to banners_path
        return false
      else
        return true
      end
    end

    def store_location
      session[:return_to] = request.request_uri
    end

    def redirect_back_or_default(default = nil)
      default ||= logged_in? ? banners_path : root_path
      redirect_to(session[:return_to] || default)
      session[:return_to] = nil
    end

    def render_error(options={})
      render :template => 'public/404.html', :layout => false, :status => options[:code] || 404
    end

end
