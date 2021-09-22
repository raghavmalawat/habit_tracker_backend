class CreateHabitFrequencies < ActiveRecord::Migration[6.1]
  def change
    create_table :habit_frequencies, id: :uuid do |t|
      t.references :habit, null: false, foreign_key: true, type: :uuid
      t.integer :monday, default: 0
      t.integer :tuesday, default: 0
      t.integer :wednesday, default: 0
      t.integer :thursday, default: 0
      t.integer :friday, default: 0
      t.integer :saturday, default: 0
      t.integer :sunday, default: 0
      t.boolean :deleted, default: false

      t.timestamps
    end
  end
end
