class CreateEnrollments < ActiveRecord::Migration[6.1]
  def change
    create_table :enrollments do |t|
      t.references :course, null: false, foreign_key: true
      t.references :student, null: false, foreign_key: { to_table: :users }
      t.integer :rating
      t.text :review
      t.integer :price

      t.timestamps
    end
  end
end
