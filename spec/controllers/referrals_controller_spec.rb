require 'rails_helper'

RSpec.describe ReferralsController, type: :controller do
  
  before(:each) do
    @user = FactoryBot.create(:user)
    allow(controller).to receive(:current_user).and_return(@user)
    allow(controller).to receive(:authenticate_user!).and_return(true)
  end

  describe 'POST #generate_code' do
    it 'generates and returns a referral code for the current user' do
      post :generate_code

      expect(response).to have_http_status(:ok)
      json_response = JSON.parse(response.body)
      expect(json_response['referral_code']).to be_present
    end
  end

  describe 'GET #referral_statistics' do
    it 'returns the referral statistics for the current user' do
     
      create(:user, referred_by: @user.id) 

      get :referral_statistics

      expect(response).to have_http_status(:ok)
      json_response = JSON.parse(response.body)
      expect(json_response['rewards_point']).to eq(@user.referral_bonus)
      expect(json_response['referral_count']).to eq(1)
    end
  end

  describe 'POST #sent_mail_to_user' do
    context 'with valid parameters' do
      it 'sends a referral email and returns a success message' do
        user_email = 'test@example.com'
        referral_link = 'http://example.com/referral_link'

        post :sent_mail_to_user, params: { email: user_email, referral_link: referral_link }

        expect(response).to have_http_status(:ok)
        json_response = JSON.parse(response.body)
        expect(json_response['message']).to eq('Referral email sent successfully')
      end
    end

    context 'with missing parameters' do
      it 'returns an error message' do
        post :sent_mail_to_user, params: { email: '', referral_link: '' }

        expect(response).to have_http_status(:unprocessable_entity)
        json_response = JSON.parse(response.body)
        expect(json_response['error']).to eq('Missing email or referral link')
      end
    end
  end
end
