class Hashtag < ApplicationRecord
  has_many :question_with_htags
  has_many :questions, through: :question_with_htags
end
