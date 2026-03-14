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

  def salary
    employee = Employee.find(params[:id])

    gross = employee.salary.to_f

    tds =
      case employee.country
      when "India"
        gross * 0.10
      when "United States"
        gross * 0.12
      else
        0
      end

    net = gross - tds

    render json: {
      gross_salary: gross.to_i,
      tds: tds.to_i,
      net_salary: net.to_i
    }
  end

  private

  def employee_params
    params.require(:employee).permit(:full_name, :job_title, :country, :salary)
  end
end
