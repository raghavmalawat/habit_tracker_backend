class User < ApplicationRecord
  has_many :habits, dependent: :destroy
  has_many :habit_logs

  validates_presence_of :first_name, :salt, :password
end
