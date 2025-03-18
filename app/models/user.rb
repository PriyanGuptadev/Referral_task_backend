class User < ApplicationRecord 
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :trackable, :omniauthable  # Removed confirmable

  include DeviseTokenAuth::Concerns::User
  after_create :handle_post_creation

  def generate_referral_code
    data = "#{id}-#{SecureRandom.hex(4)}" # Example: "12-a1b2c3d4"
    Base64.urlsafe_encode64(data) # Encodes it safely and returns the result
  end

  # Decodes the referral code and finds the referred user
  def self.decode_referral_code(referral_code)
    decoded_data = Base64.urlsafe_decode64(referral_code) rescue nil
    return nil unless decoded_data

    user_id, _random_token = decoded_data.split("-") # Extract user ID
    find_by(id: user_id) # Find user by ID
  end

  private

  def handle_post_creation
    send_welcome_email
    process_referral if referred_by.present?
  end

  def send_welcome_email
    UserMailer.welcome_email(self).deliver_later
  end

  def process_referral
    referrer = User.find_by(id: referred_by)
    return unless referrer

    referrer.increment!(:referral_bonus, 10) # Add referral bonus to the referrer
  end
end
