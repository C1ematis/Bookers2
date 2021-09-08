module BooksHelper

  def sort_order(column, title, hash_param= {})
    css_class = column == sort_column ? "current #{sort_direction}" : nil
    direction = column == sort_column && sort_direction == 'desc' ? 'asc' : 'desc'
    link_to title, {sort: column, direction: direction, search_kind: @search_kind }.merge(hash_param), class: "sort_header #{css_class}"
  end

end
