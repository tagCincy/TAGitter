class CreateProfiles < ActiveRecord::Migration[5.0]
  def change
    create_table :profiles do |t|
      t.references :user, index: true, foreign_key: { on_delete: :cascade }
      t.string :name
      t.text :bio
      t.string :location
      t.date :dob
      t.boolean :protected

      t.timestamps
    end
  end
end
