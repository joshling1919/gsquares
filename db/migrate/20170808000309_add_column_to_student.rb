class AddColumnToStudent < ActiveRecord::Migration[5.0]
  def change
    add_column :students, :daily_email, :boolean, default: false
  end
end
