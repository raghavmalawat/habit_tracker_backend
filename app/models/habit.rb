class Habit < ApplicationRecord
  has_many :habit_logs, dependent: :destroy

  belongs_to :user

  validates_presence_of :name, :target_frequency, :deleted
end
