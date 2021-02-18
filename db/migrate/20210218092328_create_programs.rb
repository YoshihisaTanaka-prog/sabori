class CreatePrograms < ActiveRecord::Migration[6.0]
  def change
    create_table :programs do |t|
      t.integer :event_program_id
      t.integer :event_id
      t.string :title
      t.date :date
      t.string :start
      t.string :end

      t.timestamps
    end
  end
end
