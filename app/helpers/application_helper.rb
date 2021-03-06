# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
def use_tinymce
    @content_for_tinymce = ""
    content_for :tinymce do
      "<script src='/javascripts/tiny_mce/tiny_mce.js' type='text/javascript' charset='utf-8'></script>"
    end
    @content_for_tinymce_init = ""
    content_for :tinymce_init do
      "<script src='/javascripts/mce_editor.js' type='text/javascript' charset='utf-8'></script>"
    end
  end

  def get_title
    title = []
    title << 'Noticias en Cuenca - Turismo Conquense'
    if @highlight
      title << @highlight.name
    elsif @category
      title << @category.name
    else
     title << t("app.#{params[:controller]}.title")
    end
    title.reverse.join(' - ')
  end

  
  def set_metadescription
    @meta_description = []
    if  @highlight
      @meta_description << @highlight.name
    elsif Settings.metas[params[:controller]]
      @meta_description << Settings.metas[params[:controller]]
    elsif @category 
     @meta_description <<  "Todas las noticias de #{@category.name} en cuenca"
    else
      ""
    end
    @meta_description << Settings.metas.default
    @meta_description = @meta_description.join(', ')
    
  end
  
  def set_keywords
    ("#{Settings.app.keywords}".downcase).split(",").map{|k| k.strip}.uniq.compact.join(", ")
    
  end

  def app_message?
    !(flash[:error].nil? and flash[:notice].nil? and flash[:info].nil?)
  end

  def app_message
    flash[:error] || flash[:notice] || flash[:info]
  end

  def app_message_type
    if flash[:error]
      'errorExplanation'
    elsif flash[:notice]
      'noticeExplanation'
    elsif flash[:info]
      'infoExplanation'
    end
  end

  def asset_packager?
    (Settings.app.include_for_asset_packager == 1) && !ie6_request?
  end

  def ie6_request?
    !(request.user_agent =~ /.+MSIE 6\..+/).nil?
  end
  
  def class_active(term,first=false)
    (params[:controller] == term || params[:category] == term || params[:category_id] == term) ? "class='active #{'first' if first}'" : "class='#{'first' if first}'"
  end
  
  def show_status_icon(status)
    status == true ? '<img src="images/ok.png" alt="ok">' : '<img src="images/ko.png" alt="ko">'
  end
  
  
  def category_links(resource=nil)
    if resource
      resource.categories.map do |category|
            link_to category.name,
            send("#{resource.class.table_name}_categories_path", category.nicename)
      end.join(', ')
    end
  end
  def navigation_tags_links(resource=nil)
    if resource
      resource.navigation.map do |tag|
            link_to(tag.name, tag_path(tag))
      end.join(', ')
    end
  end
  
  
  def get_highlight_title
    if @category
      "#{@category.name}"
    else
      "Noticias"
    end
    
  end
  
  
  def clean_text(text)
    simple_format(auto_link(strip_tags(sanitize(text)),:all, :rel => 'nofollow' ))
  end

  def simple_clean_text(text)
    auto_link(strip_tags(sanitize(text)))
  end
  
  def get_secondary_menu
    if (params[:category] || params[:category_id] )&& @category && !@category.tags.blank?
      ret = ""
      ret << '<div id="secondary_menu" class="degr_box border_box">'
      ret << "<h4>Filtros</h4>"
      ret << "<ul>"
      @category.tags.each do |tag|
        ret <<"<li #{'class=active' if params[:id] && NicenamedResource.extract_id(params[:id]) == tag.id.to_s}>#{link_to tag.name, category_tag_path(@category.nicename,tag)}</li>"
      end
      ret << "</ul>"
      ret << "</div>"
      ret
    end
  end
  
  def admin_class
    if logged_in?
      "main_content admin" if params[:controller] = "comments"
    else
      "main_content"
    end
  end
end

