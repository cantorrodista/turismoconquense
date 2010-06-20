class HomeController < ApplicationController
  
  def index
    @main_featured = Highlight.published.main_featured.first
    @featureds = Highlight.published.featured
  end
  
  def search
    render "resultados"
  end
end
