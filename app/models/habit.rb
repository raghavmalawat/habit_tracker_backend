class Habit < ApplicationRecord
  include SoftDeletable

  has_many :habit_logs, dependent: :destroy

  belongs_to :user

  validates_presence_of :name, :target_frequency

  def as_json(options = {})
    options[:except] ||= %i[deleted]
    super(options)
  end
end
