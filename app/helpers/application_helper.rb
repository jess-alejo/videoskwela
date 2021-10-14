module ApplicationHelper
  include Pagy::Frontend

  def active_link(active)
    active ? 'active' : ''
  end

  def page_title(title)
    content_for :title do
      "Videoskwela | #{title}"
    end
  end

  def progress_indicator(_current, _total)
    content_tag(:div, class: 'container.d-flex.justify-content-center.align-items-center.mb-4') do
      content_tag(:div, class: 'progresses') do
        [1, 2, 3].collect { |step| content_tag(:div, class: 'steps') { step.to_s } }
      end
    end
  end
end
