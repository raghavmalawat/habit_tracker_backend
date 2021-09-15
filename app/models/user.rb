class User < ApplicationRecord

  has_secure_password
  validates :password, length: { minimum: 5 }

  has_many :habits, dependent: :destroy
  has_many :habit_logs

  validates_presence_of :first_name

  def as_json(options = {})
    options[:except] ||= %i[password_digest deleted]
    super(options)
  end

  include SoftDeletable
end
