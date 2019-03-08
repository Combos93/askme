class CreateQuestionWithHtags < ActiveRecord::Migration[5.2]
  def change
    create_table :question_with_htags do |t|
      t.belongs_to :question, index: true
      t.belongs_to :hashtag, index: true
      t.timestamps
    end
  end
end
