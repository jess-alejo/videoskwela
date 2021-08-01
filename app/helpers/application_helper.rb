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
end
