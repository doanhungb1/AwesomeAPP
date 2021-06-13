class Employee < ApplicationRecord
  has_closure_tree

  belongs_to :user, optional: true

  validates :user_id, uniqueness: true, if: -> { user_id.present? }
  validates :name, presence: true
  validates :title, presence: true
  validate :max_subordinates_validator
  validate :max_employees

  MAX_SUBORDINATES = ENV.fetch("MAX_SUBORDINATES", 10).to_i
  MAX_EMPLOYEES = ENV.fetch("MAX_EMPLOYEES", 1000).to_i

  def employees
    self.descendants
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

  private

    def max_subordinates_validator
      return if parent_id.nil?
      return if self.parent.children.count < MAX_SUBORDINATES
      errors.add(:base, :reach_max_subordinates)
    end

    def max_employees
      return if Employee.count < MAX_EMPLOYEES
      errors.add(:base, :reach_max_employees)
    end
end
