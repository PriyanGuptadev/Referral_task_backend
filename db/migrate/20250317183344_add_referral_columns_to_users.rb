class AddReferralColumnsToUsers < ActiveRecord::Migration[8.0]
  def change
    add_column :users, :referred_by, :integer, null: true
    add_column :users, :referral_bonus, :integer, default: 0
  end
end
