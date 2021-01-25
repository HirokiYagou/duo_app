require 'rails_helper'

RSpec.describe "Exercises", type: :request do

  describe "GET /index" do
    it "returns http success" do
      get "/exercises/index"
      expect(response).to have_http_status(:success)
    end
  end

end
