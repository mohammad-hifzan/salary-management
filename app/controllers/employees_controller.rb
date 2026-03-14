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

  def salary_metrics
    if params[:country].present?
      employees = Employee.where(country: params[:country])
      salaries = employees.pluck(:salary).map(&:to_f)
      if salaries.empty?
        render json: { error: "No employees found for country #{params[:country]}" }, status: :not_found
      else
        render json: {
          country: params[:country],
          min_salary: salaries.min.to_i,
          max_salary: salaries.max.to_i,
          average_salary: (salaries.sum / salaries.size).to_i
        }
      end
    elsif params[:job_title].present?
      employees = Employee.where(job_title: params[:job_title])
      salaries = employees.pluck(:salary).map(&:to_f)
      if salaries.empty?
        render json: { error: "No employees found for job title #{params[:job_title]}" }, status: :not_found
      else
        render json: {
          job_title: params[:job_title],
          average_salary: (salaries.sum / salaries.size).to_i
        }
      end
    else
      render json: { error: "Must provide either country or job_title parameter" }, status: :bad_request
    end
  end

  private

  def employee_params
    params.require(:employee).permit(:full_name, :job_title, :country, :salary)
  end
end
