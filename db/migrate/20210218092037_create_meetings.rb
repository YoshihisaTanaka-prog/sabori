class CreateMeetings < ActiveRecord::Migration[6.0]
  def change
    create_table :meetings do |t|
      t.integer :eventId
      t.integer :fiscalYear
      t.string :eventNumber
      t.string :field
      t.string :title
      t.string :keyword
      t.string :organization
      t.date :start
      t.date :end
      t.string :place
      t.string :url

      t.timestamps
    end
  end
end
