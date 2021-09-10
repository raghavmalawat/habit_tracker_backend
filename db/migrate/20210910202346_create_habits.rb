class CreateHabits < ActiveRecord::Migration[6.1]
  def change
    create_table :habits, id: :uuid do |t|
      t.references :user, null: false, foreign_key: true, type: :uuid
      t.string :name, null: false
      t.text :description
      t.integer :target_frequency, null: false
      t.datetime :archived_at
      t.boolean :deleted, :default => false

      t.timestamps
    end
  end
end
