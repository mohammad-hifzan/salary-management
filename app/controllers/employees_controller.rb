class EmployeesController < ApplicationController
  def index
    employees = Employee.all
    render json: employees
  end

  def show
    employee = Employee.find(params[:id])
    render json: employee
  end

  def create
    employee = Employee.create!(employee_params)
    render json: employee, status: :created
  end

  def update
    employee = Employee.find(params[:id])
    employee.update!(employee_params)
    render json: employee
  end

  def destroy
    employee = Employee.find(params[:id])
    employee.destroy
    head :no_content
  end

  private

  def employee_params
    params.require(:employee).permit(:full_name, :job_title, :country, :salary)
  end
end
