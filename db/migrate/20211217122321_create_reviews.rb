class CreateReviews < ActiveRecord::Migration[6.1]
  def change
    create_table :reviews do |t|
      t.references :reviewable, null: false, polymorphic: true, index: true
      t.references :user, null: false, foreign_key: true
      t.integer :rating
      t.text :message

      t.timestamps
    end
  end
end
