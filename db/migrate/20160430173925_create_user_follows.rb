class CreateUserFollows < ActiveRecord::Migration[5.0]
  def change
    create_table :user_follows do |t|
      t.references :follow, index: true
      t.references :follower, index: true

      t.timestamps
    end

    add_column :users, :follow_count, :integer, default: 0
    add_column :users, :follower_count, :integer, default: 0

    add_foreign_key :user_follows, :users, column: :follow_id, on_delete: :cascade
    add_foreign_key :user_follows, :users, column: :follower_id, on_delete: :cascade
  end
end
