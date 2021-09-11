class HabitLog < ApplicationRecord
  belongs_to :user
  belongs_to :habit

  validates_presence_of :achieved_frequency, :log_date
end
