class UserSessionsController < ApplicationController
  before_filter :require_no_session, :only => [:create, :new]
  def new
    @user_session = UserSession.new
  end


  def create
    @user_session = UserSession.new(params[:user_session])
    @user_session.save do |result|
      if result
        flash[:notice] = t('flash.user_sessions.create.notice',:user => @user_session.user.login)
          redirect_to banners_path
      else
        render :action => :new
      end
    end
  end

  def destroy
    current_user.reset_persistence_token!
    current_user_session.destroy
    flash[:notice] = t('flash.user_sessions.destroy.notice')
    redirect_to new_user_session_url
  end



end
