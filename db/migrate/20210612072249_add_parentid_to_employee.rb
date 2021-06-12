class AddParentidToEmployee < ActiveRecord::Migration[6.1]
  def change
    add_column :employees, :parent_id, :integer
  end
end
