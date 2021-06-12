class CreateEmployeeHierarchies < ActiveRecord::Migration[6.1]
  def change
    create_table :employee_hierarchies, id: false do |t|
      t.integer :ancestor_id, null: false
      t.integer :descendant_id, null: false
      t.integer :generations, null: false
    end

    add_index :employee_hierarchies, [:ancestor_id, :descendant_id, :generations],
      unique: true,
      name: "employee_anc_desc_idx"

    add_index :employee_hierarchies, [:descendant_id],
      name: "employee_desc_idx"
  end
end
