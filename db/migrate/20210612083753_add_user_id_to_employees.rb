class AddUserIdToEmployees < ActiveRecord::Migration[6.1]
  def change
    add_column :employees, :user_id, :integer
  end
end
