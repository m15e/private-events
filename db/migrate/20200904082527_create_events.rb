class CreateEvents < ActiveRecord::Migration[6.0]
  def change
    create_table :events do |t|
      t.string :time
      t.string :location
      t.string :title
      t.text :description

      t.timestamps
    end
  end
end
