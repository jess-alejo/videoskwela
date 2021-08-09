module UsersHelper
  def online_status(user)
    return unless user.online?

    content_tag :small, 'online', class: 'badge bg-success'
  end

  def email_confirmation_status(user)
    if user.confirmed_at.present?
      text = 'confirmed'
      style = 'bg-success'
    else
      text = 'unconfirmed'
      style = 'bg-danger'
    end

    content_tag :small, text, class: "badge #{style}"
  end
end
