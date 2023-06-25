class AddMembersStatusToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :members_status, :boolean, default: false, null: false
  end
end
