class DeviseTokenAuthCreateUsers < ActiveRecord::Migration
  def change
    add_column :users, :provider, :string, null: false, default: "email"
    add_column :users, :uid, :string
    add_column :users, :tokens, :jsonb, index: { using: :gin }
  end
end
