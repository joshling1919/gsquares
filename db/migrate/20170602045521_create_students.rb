class CreateStudents < ActiveRecord::Migration[5.0]
  def change
    create_table :students do |t|
      t.string :name, null: false
      t.string :email, null: false, index: true
      t.string :image_url
      t.string :github_squares
      t.integer :cohort, default: 0
      t.integer :coach, default: 0
      t.timestamps
    end
  end
end
