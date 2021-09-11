require 'rails_helper'

RSpec.describe DailyHabit, type: :model do
  describe "Associations" do
    it { should belong_to(:habit) }
  end
end
