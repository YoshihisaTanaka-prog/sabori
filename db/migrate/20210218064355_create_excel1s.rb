class CreateExcel1s < ActiveRecord::Migration[6.0]
  def change
    create_table :excel1s do |t|
      t.string :title
      t.string :body

      t.timestamps
    end
  end
end
