class AddColumnTitleToMicroposts < ActiveRecord::Migration[8.0]
  def change
    add_column :microposts, :title, :string, limit: 100
  end
end
