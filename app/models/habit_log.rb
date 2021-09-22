class HabitLog < ApplicationRecord
  include SoftDeletable

  belongs_to :user
  belongs_to :habit

  validates_presence_of :achieved_frequency, :log_date

  def as_json(options = {})
    options[:except] ||= [%i[deleted]]
    super(options)
  end
end
