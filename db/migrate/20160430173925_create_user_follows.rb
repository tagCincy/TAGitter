class CreateUserFollows < ActiveRecord::Migration[5.0]
  def change
    create_table :user_followers do |t|
      t.references :followed, index: true
      t.references :follower, index: true

      t.timestamps
    end

    add_column :users, :followed_count, :integer, default: 0
    add_column :users, :follower_count, :integer, default: 0

    add_foreign_key :user_followers, :users, column: :followed_id, on_delete: :cascade
    add_foreign_key :user_followers, :users, column: :follower_id, on_delete: :cascade
  end
end
