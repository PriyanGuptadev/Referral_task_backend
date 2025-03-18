class UserMailer < ApplicationMailer
  default from: "your-email@example.com"

  def welcome_email(user)
    @user = user
    mail(to: @user.email, subject: "Welcome to Our Platform!")
  end

  def referral_email(user_email, referral_link)
    @referral_link = referral_link
    mail(to: user_email, subject: "You've been invited!")
  end
end
