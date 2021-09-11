require 'rails_helper'

RSpec.describe User, type: :model do
  describe "Validations" do
    it { should validate_presence_of(:first_name) }
    it { should validate_presence_of(:salt) }
    it { should validate_presence_of(:password) }
  end

end
