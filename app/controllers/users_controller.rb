class UsersController < ApplicationController
  def index
    @users = [
      User.new(
        id: 1,
        name: 'Vadim',
        username: 'installero',
        avatar_url: 'https://ih0.redbubble.net/image.213186038.0307/st%2Csmall%2C215x235-pad%2C210x230%2Cf8f8f8.lite-1u1.jpg'
      ),
      User.new(
        id: 2,
        name: 'Misha',
        username: 'aristofun'
      )
    ]
  end

  def new
  end

  def edit
  end

  def show
    @user = User.new(
      name: 'Misha',
      username: 'Combos',
      avatar_url: 'https://ih0.redbubble.net/image.213186038.0307/st%2Csmall%2C215x235-pad%2C210x230%2Cf8f8f8.lite-1u1.jpg'
    )

    @questions = [
      Question.new(text: 'Как дела?', created_at: Date.parse('14.02.2019')),
      Question.new(text: 'В чём смысл жизни?', created_at: Date.parse('14.02.2019'))
    ]

    @new_question = Question.new
  end
end
