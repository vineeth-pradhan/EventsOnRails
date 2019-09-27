class CreateRsvps < ActiveRecord::Migration[5.1]
  def change
    create_table :rsvps do |t|
      t.string :response
      t.integer :event_id
      t.integer :user_id

      t.timestamps
    end
  end
end
