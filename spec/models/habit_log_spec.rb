require 'rails_helper'

RSpec.describe HabitLog, type: :model do
  describe "Associations" do
    it { should belong_to(:user) }
    it { should belong_to(:habit) }
  end

  describe "Validations" do
    it { should validate_presence_of(:log_date) }
    it { should validate_presence_of(:achieved_frequency) }
  end
end
