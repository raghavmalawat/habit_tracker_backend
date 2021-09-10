class CreateDailyHabits < ActiveRecord::Migration[6.1]
  def change
    create_table :daily_habits, id: :uuid do |t|
      t.references :habit, null: false, foreign_key: true, type: :uuid
      t.boolean :monday, :default => false
      t.boolean :tuesday, :default => false
      t.boolean :wednesday, :default => false
      t.boolean :thursday, :default => false
      t.boolean :friday, :default => false
      t.boolean :saturday, :default => false
      t.boolean :sunday, :default => false
      t.boolean :deleted, :default => false

      t.timestamps
    end
  end
end
