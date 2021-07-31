module ApplicationHelper
  include Pagy::Frontend

  def active_link(active)
    active ? 'active' : ''
  end
end
