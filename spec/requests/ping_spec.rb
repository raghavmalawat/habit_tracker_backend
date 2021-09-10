require 'rails_helper'

RSpec.describe "Ping", type: :request do
  describe "GET /index" do
    it "returns http success" do
      get "/ping"
      expect(response).to have_http_status(:success)
    end
  end

end
