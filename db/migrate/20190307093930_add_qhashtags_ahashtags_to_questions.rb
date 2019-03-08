class AddQhashtagsAhashtagsToQuestions < ActiveRecord::Migration[5.2]
  def change
    add_column :questions, :qhashtags, :string
    add_column :questions, :ahashtags, :string
  end
end
