module ApplicationHelper
  include Pagy::Frontend

  def active_link(active)
    active ? 'active' : ''
  end

  def page_title(title)
    content_for :page_title, title
  end

  def breadcrumb(link)
    li = tag.li(class: "breadcrumb-item") do
      link
    end

    content_for :breadcrumb, li
  end

  def top_button(text, url, options = {})
    icon = tag.i(data: { "acorn-icon" => options[:icon] }, class: "me-1")
    label = tag.span(text)

    class_names = class_names("btn btn-primary btn-icon btn-icon-start w-100 w-sm-auto ms-1", options[:class])
    button = content_tag(:a, href: url, class: class_names) do
      icon.concat(label)
    end

    content_for :top_button, button
  end

  def progress_indicator(_current, _total)
    content_tag(:div, class: 'container.d-flex.justify-content-center.align-items-center.mb-4') do
      content_tag(:div, class: 'progresses') do
        [1, 2, 3].collect { |step| content_tag(:div, class: 'steps') { step.to_s } }
      end
    end
  end

  def space
    # prevent haml whitespace being stripped in staging and production
    # which would lead to elements being stuck together.
    # As in development whitespace is not stripped, it looks good in
    # development even without this helper.
    " "
  end
end
