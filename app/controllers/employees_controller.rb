class EmployeesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_employee, only: %i[ show edit update destroy employees managers relationship]

  # GET /employees or /employees.json
  def index
    @employees = Employee.order(created_at: :asc)
    @employees = @employees.limit(params[:number_first_employees].to_i) if params[:number_first_employees].present?
  end

  # GET /employees/1 or /employees/1.json
  def show
  end

  # GET /employees/new
  def new
    @employee = Employee.new
  end

  # GET /employees/1/edit
  def edit
    @employees = Employee.order(updated_at: :desc)
  end

  # POST /employees or /employees.json
  def create
    @employee = Employee.new(employee_params)

    respond_to do |format|
      if @employee.save
        format.html { redirect_to @employee, notice: "Employee was successfully created." }
        format.json { render :show, status: :created, location: @employee }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @employee.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /employees/1 or /employees/1.json
  def update
    respond_to do |format|
      if @employee.update(employee_params)
        format.html { redirect_to @employee, notice: "Employee was successfully updated." }
        format.json { render :show, status: :ok, location: @employee }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @employee.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /employees/1 or /employees/1.json
  def destroy
    @employee.destroy
    respond_to do |format|
      format.html { redirect_to employees_url, notice: "Employee was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  # GET /employees/1/managers
  def managers
    @searched_managers = @employee.managers
    respond_to do |format|
      format.js
    end
  end

  # GET /employees/1/employees
  def employees
    @searched_employees = @employee.employees
    respond_to do |format|
      format.js
    end
  end

  # GET /employees/1/relationship/2
  def relationship
    @relationship = @employee.relationship_with_employee(Employee.find(params[:target_employee_id]))
    respond_to do |format|
      format.js
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_employee
      @employee = Employee.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def employee_params
      params.require(:employee).permit(:name, :title, :parent_id)
    end
end
