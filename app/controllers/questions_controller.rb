class QuestionsController < ApplicationController

  before_action :load_question, only: [:edit, :update, :destroy]
  before_action :authorize_user, except: [:create]
  # after_action :set_author, only: [:create]

  # GET /questions/1/edit
  def edit
  end

  # POST /questions
  def create
    @question = Question.new(question_params)

    attach_author

    if @question.save && check_captcha(@question)
      # @new_htag = Question.hashtag
      # @new_htag = QuestionWithHtag.where(question_id: @question).hashtag

      redirect_to user_path(@question.user), notice: 'Ваш вопрос успешно создан для пользователя.'
    else
      render :edit
    end
  end

  # PATCH/PUT /questions/1
  def update
    if @question.update(question_params)
      redirect_to user_path(@question.user), notice: 'Ваш вопрос успешно обновлён.'
    else
      render :edit
    end
  end

  # DELETE /questions/1
  def destroy
    user = @question.user
    @question.destroy

    redirect_to user_path(user), notice: 'Ваш вопрос успешно удалён.'
  end

  private

  def attach_author
    @question.author = current_user unless session[:user_id] == nil
  end

  def load_question
    @question = Question.find(params[:id])
  end

  def question_params
    if current_user.present? && params[:question][:user_id].to_i == current_user.id
      params.require(:question).permit(:user_id, :text, :answer)
    else
      params.require(:question).permit(:user_id, :text)
    end
  end

  def authorize_user
    reject_user unless @question.user == current_user
  end

  def check_captcha(model)
    if current_user.present?
      true
    else
      verify_recaptcha(model: model)
    end
  end
end
