class HabitFrequency < ApplicationRecord
  include SoftDeletable

  belongs_to :habit

  def as_json(options = {})
    options[:except] ||= [%i[deleted]]
    super(options)
  end
end
