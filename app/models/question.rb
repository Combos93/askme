class Question < ApplicationRecord
  belongs_to :user
  belongs_to :author, class_name: 'User', optional: true

  has_many :hashtags_questions, dependent: :destroy
  has_many :hashtags, through: :hashtags_questions

  validates :text, :user, presence: true
  validates :text, length: { maximum: 255}

  after_commit :extract_htags
  after_commit :destroy_unused_hashtags

  private

  def extract_htags
    hashtags_questions.clear

    q_a = "#{text} #{answer}".downcase.split
    q_a = q_a.uniq
    q_a = q_a.join(", ")

    q_a.scan(/#[[:word:]_]+/).uniq.each do |name|
      hashtags << Hashtag.find_or_create_by!(tag: name)
    end
  end

  def destroy_unused_hashtags
    Hashtag.left_outer_joins(:questions).where(questions: { id: nil }).destroy_all
  end
end
