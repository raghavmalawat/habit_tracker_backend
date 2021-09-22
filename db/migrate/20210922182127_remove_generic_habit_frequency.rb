class RemoveGenericHabitFrequency < ActiveRecord::Migration[6.1]
  def change
    remove_column :habits, :target_frequency

  end
end
