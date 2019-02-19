class AddHeadersColorToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :headers_color, :string
  end
end
