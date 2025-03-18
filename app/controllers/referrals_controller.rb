class ReferralsController < ApplicationController
  before_action :authenticate_user! 

  def generate_code
    render json: { referral_code: current_user.generate_referral_code }, status: :ok
  end

  def referral_statistics
    rewards = current_user.referral_bonus
    referral_count = User.where(referred_by: current_user.id).count  
    
    render json: { rewards_point: rewards, referral_count: referral_count }, status: :ok
  end
end
