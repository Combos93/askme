class CreateHashtags < ActiveRecord::Migration[5.2]
  def change
    create_table :hashtags do |t|
      t.string :tag
    end
    add_index :hashtags, :tag, unique: true
  end
end
