class User < ApplicationRecord 
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :trackable, :omniauthable  # Removed confirmable

  include DeviseTokenAuth::Concerns::User
end
