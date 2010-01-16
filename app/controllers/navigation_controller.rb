class NavigationController < InheritedResources::Base

  def show
    collection  
  end
  
  private
  
  def collection
      @tag = Tag.find(NicenamedResource.extract_id(params[:id]))
      @category = Category.find_by_nicename(params[:category_id])
      @highlights ||= Highlight.paginate(:page => params[:page],
          :per_page => 10, :order => 'date DESC',
          :include => [:taggings,:highlight_categories],
          :conditions => ['highlight_categories.category_id = ? and highlights.published = ?  and taggings.tag_id = ? and taggings.taggable_type = ? and taggings.context = ?', @category.id,true, @tag.id,"Highlight","navigation"])

  end
end
