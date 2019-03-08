class Question < ApplicationRecord
  belongs_to :user
  belongs_to :author, class_name: 'User', optional: true
  has_many :question_with_htags
  has_many :hashtags, through: :question_with_htags

  validates :text, :user, presence: true
  validates :text, length: { maximum: 255}

  after_commit :question_hashtags, on: :create
  # after_commit :question_hashtags, :answer_hashtags, on: :update

  def question_hashtags
    @q_hashtags = []

    content_q = self.text.split(" ")
    content_q.map do |word|
      if word.include?("#")
        @q_hashtags << word
      end
    end
    @q_hashtags = @q_hashtags.join(" ")

    self.qhashtags = @q_hashtags
  end

  def answer_hashtags
    @a_hashtags = []

    unless answer == nil
      content_a = answer.split(" ")
      content_a.each do |word|
        if word.include?("#")
          @a_hashtags << word
        end
      end
      @a_hashtags = @a_hashtags.join(" ")

      question.ahashtags = @a_hashtags
    end
  end
end
