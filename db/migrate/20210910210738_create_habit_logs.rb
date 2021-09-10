class CreateHabitLogs < ActiveRecord::Migration[6.1]
  def change
    create_table :habit_logs, id: :uuid do |t|
      t.references :user, null: false, foreign_key: true, type: :uuid
      t.references :habit, null: false, foreign_key: true, type: :uuid
      t.integer :achieved_frequency, :default => 0
      t.datetime :log_date
      t.boolean :deleted, :default => false

      t.timestamps
    end
  end
end
