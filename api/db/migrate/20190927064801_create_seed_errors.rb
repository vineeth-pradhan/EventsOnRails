class CreateSeedErrors < ActiveRecord::Migration[5.1]
  def change
    create_table :seed_errors do |t|
      t.text :description

      t.timestamps
    end
  end
end
