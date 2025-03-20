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

  def joined_email(referrer_email, joined_user_email)
     @joined_user_email = joined_user_email
     @referrer_user_email = referrer_email 
     mail(to: @referrer_user_email, subject: "User has joined!")
  end  
end
