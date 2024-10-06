class CreateEvents < ActiveRecord::Migration[7.0]
  def change
    create_table :events do |t|
      t.string :title
      t.references :employee, null: false, foreign_key: true
      t.string :event_type
      t.boolean :read

      t.timestamps
    end
  end
end
