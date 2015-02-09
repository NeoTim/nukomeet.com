# All files in the 'lib' directory will be loaded
# before nanoc starts compiling.

include Nanoc3::Helpers::Blogging
include Nanoc3::Helpers::LinkTo
include Nanoc3::Helpers::Rendering
include Nanoc3::Helpers::XMLSitemap
include Nanoc3::Helpers::Tagging

def link_to_with_current(text, path, desc)
  if @item_rep and @item_rep.path == path
    "<li class='active'>#{link_to(text, path, :'data-description' => desc)}</li>"
  else
    "<li>#{link_to(text, path, :'data-description' => desc)}</li>"
  end
end

def items_by_author(author)
  @items.select { |i| (i[:authors] || []).include?(author) }
end

def projects
  @items.select { |item| item[:kind] == 'project' }
end

def sorted_projects
  projects.sort_by do |a|
    attribute_to_time(a[:created_at])
  end.reverse
end

def page_cover_url(item)
  return 'http://nukomeet.com/assets/images/company.jpg' if item[:cover].nil?
  return item[:cover] if item[:cover] =~ /(https|http):\/\//
  return "http://nukomeet.com#{item[:cover]}"
end
