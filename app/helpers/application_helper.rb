module ApplicationHelper
  def page_entries_info(collection, options = {})
    entry_name = options[:entry_name] || (collection.empty?? 'entry' : collection.first.class.name.underscore.sub('_', ' '))

    if collection.total_pages < 2
      case collection.size
      when 0; "No #{entry_name.pluralize} found"
      when 1; "Displaying <b>1</b> #{entry_name}"
      else;   "Displaying <b>all #{collection.size}</b> #{entry_name.pluralize}"
      end
    else
      "Displaying #{collection.offset + collection.length} of <b>#{collection.total_entries}</b> #{entry_name.pluralize}"
    end
  end
end
