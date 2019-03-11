class HashtagController < ApplicationController
  def index
    @q_tags = Question.pluck(:qhashtags).uniq
    @a_tags = Question.pluck(:ahashtags).uniq
  end

  def show

  end
end
