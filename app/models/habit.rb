class Habit < ApplicationRecord
  include SoftDeletable

  has_many :habit_logs, dependent: :destroy
  has_one :habit_frequency
  accepts_nested_attributes_for :habit_frequency, allow_destroy: true

  belongs_to :user

  validates_presence_of :name

  def as_json(options = {})
    options[:except] ||= %i[deleted]
    options[:include] ||= { habit_frequency: { except: %i[deleted habit_id created_at updated_at] } }
    options[:except] ||= %i[deleted]
    hash = super(options)
    hash[:frequency] = hash.delete('habit_frequency')
    hash
  end
end
