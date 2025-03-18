class Users::RegistrationsController < Devise::RegistrationsController
  skip_before_action :verify_authenticity_token, only: [:create]

  def create
    user = User.new(sign_up_params)

    # Check if referral code is present
    if params[:referral_code].present?
      referrer = User.decode_referral_code(params[:referral_code])

      if referrer
        user.referred_by = referrer.id
      else
        return render json: { error: "Invalid referral code" }, status: :unprocessable_entity
      end
    end

    if user.save
      render json: { message: "User created successfully", user: user }, status: :created
    else
      render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def sign_up_params
    params.permit(:email, :password, :password_confirmation, :referral_code)
  end
end
