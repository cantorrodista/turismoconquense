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
end

