class Employee < ApplicationRecord
  has_closure_tree

  belongs_to :user, optional: true

  validates :user_id, uniqueness: true, if: -> { user_id.present? }
  validates :name, presence: true
  validates :title, presence: true

  def employees
    self.siblings
  end

  def managers
    self.ancestors
  end

  def relationship_with_employee(emp)
    employees_names = {
      first_employee_name: self.name,
      second_employee_name: emp.name
    }
    return I18n.t('relationship_with_employee.same') if self.id == emp.id
    return I18n.t('relationship_with_employee.manager', employees_names) if self.ancestor_of?(emp)
    return I18n.t('relationship_with_employee.subordinate', employees_names) if self.descendant_of?(emp)
    I18n.t('relationship_with_employee.no_relationship', employees_names)
  end
end
