class AddCompleteRowForEvent < ActiveRecord::Migration[5.1]
  def up
    add_column :events, :complete, :boolean, null: false, default: false
  end

  def down
    remove_column :events, :complete
  end
end
