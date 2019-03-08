module ApplicationHelper
  def user_avatar(user)
    if user.avatar_url.present?
      user.avatar_url
    else
      asset_path 'avatar.jpg'
    end
  end

  def sklonenie(questions, vopros, voprosa, voprosov)
    ostatok = questions % 10

    return " #{vopros}" if ostatok == 1
    return " #{voprosa}" if ostatok.between?(2, 4)
    return " нет #{voprosov}" if questions == 0

    " #{voprosov}"
  end

  def fa_icon(icon_class)
    content_tag 'span', '',
                class: "fa fa-#{icon_class}"
  end
end
