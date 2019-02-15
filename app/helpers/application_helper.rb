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
      return vopros
    end

    if ostatok.between?(2, 4)
      return voprosa
    end

    #if questions == 0
    #  return "У вас нет вопросов."
    #end

    voprosov
  end
end
