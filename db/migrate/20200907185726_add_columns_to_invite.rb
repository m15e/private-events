class AddColumnsToInvite < ActiveRecord::Migration[6.0]
  def change
    add_column :invites, :event_id, :integer
    add_column :invites, :user_id, :integer
  end
end
