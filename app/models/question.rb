class Question < ApplicationRecord
  belongs_to :user
  belongs_to :author, class_name: 'User', optional: true

  has_many :hashtags_questions, dependent: :destroy
  has_many :hashtags, through: :hashtags_questions, dependent: :destroy

  validates :text, :user, presence: true
  validates :text, length: { maximum: 255}

  before_save :extract_htags

  private

  def extract_htags
    hashtags_questions.clear

    "#{text} #{answer}".scan(/#[[:word:]_]+/).uniq.each do |name|
      hashtags << Hashtag.find_or_create_by!(tag: name)
    end
  end
end
