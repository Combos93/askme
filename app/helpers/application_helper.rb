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

    if ostatok == 1
      return "#{@questions.count} #{vopros}"
    end

    if ostatok.between?(2, 4)
      return "#{@questions.count} #{voprosa}"
    end

    if questions == 0
      return " нет #{voprosov}"
    end

    "#{@questions.count} #{voprosov}"
  end

  def fa_icon(icon_class)
    content_tag 'span', '', class: "fa fa-#{icon_class}"
  end
end
