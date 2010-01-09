class RatingsController < ApplicationController
  before_filter :require_session if Settings.ratings.login_required == 1
  
  def create
    # No hago nada si la clase no se puede votar
    if !Settings.ratings.classes.include?(params[:klass])
      render :status => 200,:nothing => true and return
    end

    begin
      klass = params[:klass].constantize
      object = klass.find(params[:id].to_i)
    rescue NameError, ActiveRecord::RecordNotFound  => e
      logger.error "Error en rating, no existe el #{params[:klass]} con id #{params[:id]} #{params.to_json}"
      render :status => 200,:nothing => true 
      return
    end

    key = "already_voted_#{params[:klass]}_#{params[:id]}"
    if Settings.ratings.unlimited_votes == 0
      if session[key] && !current_user
        new_vote = false
      else
        new_vote = true
        session[key] = true 
      end
    else 
      new_vote = true
    end
    if new_vote == true
      rating = params[:rating].to_i
      user = current_user ? current_user : nil
      object.rate rating, user
    end
    render :update do |page|
      div_id = "highlight-rating-#{params[:klass].downcase}-#{params[:id]}"
      page.replace_html div_id, :partial => 'ratings/current_rating', 
      :locals => { :object => object, :new_vote => new_vote }
    end
  end
end