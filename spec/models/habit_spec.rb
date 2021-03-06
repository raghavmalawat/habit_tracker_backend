require 'rails_helper'

RSpec.describe Habit, type: :model do
  describe "Associations" do
    it { should belong_to(:user) }
  end

  describe "Validations" do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:deleted) }
  end
end
