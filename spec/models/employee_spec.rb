require 'rails_helper'

RSpec.describe Employee, type: :model do

  let(:employee) { create(:employee) }
  subject { build(:employee) }

  it { is_expected.to belong_to(:user).optional }
  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_presence_of(:title) }

  context "if user_id blank" do
    before { allow(subject).to receive(:user_id).and_return(nil) }
    it { should_not validate_uniqueness_of(:user_id) }
  end
  
  describe "max_employees_validator" do
    it "raised when max employees reached" do
      Employee::MAX_EMPLOYEES.times do |_|
        create(:employee)
      end
      last_employee = build(:employee)
      last_employee.valid?
      error_msg = I18n.t("activerecord.errors.models.employee.attributes.base.reach_max_employees")
      expect(last_employee.errors.messages[:base]).to eq([error_msg])
    end
  end

  describe "max_subordinates_validator" do
    it "raised when max subordinate reached" do

      parent_employee = create(:employee)
      Employee::MAX_SUBORDINATES.times do |_|
        create(:employee, parent_id: parent_employee.id)
      end
      last_employee = build(:employee, parent_id: parent_employee.id)
      last_employee.valid?
      error_msg = I18n.t("activerecord.errors.models.employee.attributes.base.reach_max_subordinates")
      expect(last_employee.errors.messages[:base]).to eq([error_msg])
    end
  end

  describe "relationship_with_employee" do
    before :each do
      @emp_1 = create :employee
      @emp_2 = create :employee
      @employees_names = {
        first_employee_name: @emp_1.name,
        second_employee_name: @emp_2.name
      }
    end

    context "when emp1 is manager" do
      it "return the manager message" do
        message = I18n.t('relationship_with_employee.manager', @employees_names)
        @emp_2.update(parent_id: @emp_1.id)
        expect(@emp_1.relationship_with_employee(@emp_2)).to eq(message)
      end
    end

    context "when emp1 is employee" do
      it "return the employee message" do
        message = I18n.t('relationship_with_employee.subordinate', @employees_names)
        @emp_1.update(parent_id: @emp_2.id)
        expect(@emp_1.relationship_with_employee(@emp_2)).to eq(message)
      end
    end

    context "when emp1 and emp2 have no relationship" do
      it "return the employee message" do
        message = I18n.t('relationship_with_employee.no_relationship', @employees_names)
        expect(@emp_1.relationship_with_employee(@emp_2)).to eq(message)
      end
    end
  end
end
