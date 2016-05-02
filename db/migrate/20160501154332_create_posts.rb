class CreatePosts < ActiveRecord::Migration[5.0]
  def change
    enable_extension 'uuid-ossp'

    create_table :posts, id: :uuid do |t|
      t.text :body, null: true
      t.references :user, index: true, foreign_key: { on_delete: :cascade }
      t.uuid :repost_id, index: true
      t.integer :reposted_count, default: 0
      t.boolean :deleted, default: false
      t.timestamps
    end

    add_column :users, :posts_count, :integer, default: 0

    add_foreign_key :posts, :posts, column: :repost_id, on_delete: :cascade
  end
end
