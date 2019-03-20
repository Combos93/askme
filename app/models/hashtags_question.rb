class HashtagsQuestion < ApplicationRecord
  belongs_to :question
  belongs_to :hashtag, dependent: :destroy

  validates :hashtag_id, uniqueness: { scope: :question_id }
end
