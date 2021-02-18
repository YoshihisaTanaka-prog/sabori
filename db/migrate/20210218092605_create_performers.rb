class CreatePerformers < ActiveRecord::Migration[6.0]
  def change
    create_table :performers do |t|
      t.integer :event_id
      t.integer :event_program_id
      t.string :organization
      t.string :role
      t.string :lastname
      t.string :firstname

      t.timestamps
    end
  end
end
