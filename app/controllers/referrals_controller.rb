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

  def sent_mail_to_user
    user_email = params[:email]
    referral_link = params[:referral_link]

    if user_email.present? && referral_link.present?
      UserMailer.referral_email(user_email, referral_link).deliver_later
      render json: { message: 'Referral email sent successfully' }, status: :ok
    else
      render json: { error: 'Missing email or referral link' }, status: :unprocessable_entity
    end
  end  
end
