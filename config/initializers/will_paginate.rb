require 'will_paginate/view_helpers/link_renderer'
require 'will_paginate/view_helpers/action_view'

module WillPaginate
  module ActionView
    def will_paginate(collection = nil, options = {})
      options[:renderer] ||= CustomRenderer
      super.try :html_safe
    end

    class CustomRenderer < WillPaginate::ActionView::LinkRenderer
      def container_attributes
        { class: "pagination" }
      end

      def page_number(page)
        tag(:li, link(page, page, rel: rel_value(page), class: "page-link"), class: "page-item")
      end

      def previous_or_next_page(page, text, classname)
        tag(:li, link(text, page || '#', class: "page-link"), class: "page-item #{'disabled' unless page}")
      end

      def html_container(html)
        tag(:ul, html, container_attributes)
      end
    end
  end
end
