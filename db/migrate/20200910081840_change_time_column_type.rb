class ChangeTimeColumnType < ActiveRecord::Migration[6.0]
  def change
    remove_column :events, :time, :string
    add_column :events, :time, :datetime
  end
end
