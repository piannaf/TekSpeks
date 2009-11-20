# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper

  def page_header
    
    case params[:action]
    when 'index'
      content_tag(:div,
        content_tag(:div, "Listing #{params[:controller].humanize}", :class => "page_title") +
        new_box,
      :class => "page_header")
    when 'edit'
      content_tag(:div,
        content_tag(:div, "Editing #{params[:controller].humanize.singularize}", :class => "page_title"),
      :class => "page_header")
    when 'new'
      content_tag(:div,
        content_tag(:div, "New #{params[:controller].humanize.singularize}", :class => "page_title"),
      :class => "page_header")
    when 'show'
      content_tag(:div,
        content_tag(:div, "Viewing #{params[:controller].humanize.singularize}", :class => "page_title") +
        new_box,
      :class => "page_header")
    when 'delete'
       content_tag(:div,
        content_tag(:div, "Confirm Delete", :class => "page_title"),
      :class => "page_header")   	
    else
       content_tag(:div,
        content_tag(:div, "Bad Request", :class => "page_title"),
      :class => "page_header")   	
    end

  end
  
  def new_box
  	content_tag(:div, content_tag(:div, "#{flash[:notice]} ", :class => "flash_notice") +
      link_to("New #{controller.controller_name.singularize}", :controller => controller.controller_name, :action => 'new'),
      :class => "new_something")
  end

end
