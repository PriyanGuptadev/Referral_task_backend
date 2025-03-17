class AddDeviseTokenAuthFieldsToUsers < ActiveRecord::Migration[8.0]
  def change
    change_table :users do |t|
      ## Required
      t.string :provider, null: false, default: "email"
      t.string :uid, null: false, default: ""

      ## Tokens (for authentication)
      t.text :tokens

      ## Allow password change
      t.boolean :allow_password_change, default: false

      ## Confirmable (if using email confirmation)
      t.string   :confirmation_token
      t.datetime :confirmed_at
      t.datetime :confirmation_sent_at
      t.string   :unconfirmed_email

      ## Additional fields (optional)
      t.string :name
      t.string :nickname
      t.string :image
    end

    add_index :users, [:uid, :provider], unique: true
  end
end
