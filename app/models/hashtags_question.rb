class HashtagsQuestion < ApplicationRecord
  belongs_to :question
  belongs_to :hashtag

  validates :hashtag_id, uniqueness: { scope: :question_id }
end
