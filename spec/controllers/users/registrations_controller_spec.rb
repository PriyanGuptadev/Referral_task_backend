require 'rails_helper'

RSpec.describe Users::RegistrationsController, type: :request do
  let(:valid_user_params) do
    {
      email: "test@example.com",
      password: "password123",
      password_confirmation: "password123"
    }
  end

  describe "POST /auth" do
    context "when valid parameters are provided" do
      it "creates a new user" do
        expect {
          post "/auth", params: valid_user_params
        }.to change(User, :count).by(1)

        expect(response).to have_http_status(:created)
        json_response = JSON.parse(response.body)
        expect(json_response["message"]).to eq("User created successfully")
      end
    end

    context "when invalid referral code is provided" do
      let(:invalid_referral_params) { valid_user_params.merge(referral_code: "invalid_code") }

      it "returns an error" do
        post "/auth", params: invalid_referral_params

        expect(response).to have_http_status(:unprocessable_entity)
        json_response = JSON.parse(response.body)
        expect(json_response["error"]).to eq("Invalid referral code")
      end
    end

    context "when missing required parameters" do
      let(:invalid_user_params) { { email: "test@example.com" } }

      it "returns an error" do
        post "/auth", params: invalid_user_params

        expect(response).to have_http_status(:unprocessable_entity)
        json_response = JSON.parse(response.body)
        expect(json_response["errors"]).to include("Password can't be blank")
      end
    end
  end
end
