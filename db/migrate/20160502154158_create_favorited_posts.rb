class CreateFavoritedPosts < ActiveRecord::Migration[5.0]
  def change
    create_table :favorited_posts do |t|
      t.uuid :post_id, index: true
      t.references :user, index: true, foreign_key: { on_delete: :cascade }

      t.timestamps
    end

    add_column :posts, :favorited_count, :integer, default: 0
    add_foreign_key :favorited_posts, :posts, column: :post_id, on_delete: :cascade
  end
end
