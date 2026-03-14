require 'rails_helper'

RSpec.describe "Employees API", type: :request do
  let!(:employees) { create_list(:employee, 3) }
  let(:employee_id) { employees.first.id }

  describe "GET /employees" do
    it "returns all employees" do
      get "/employees"

      expect(response).to have_http_status(:ok)

      body = JSON.parse(response.body)
      expect(body.length).to eq(3)
    end
  end

  describe "GET /employees/:id" do
    it "returns the employee" do
      get "/employees/#{employee_id}"

      expect(response).to have_http_status(:ok)

      body = JSON.parse(response.body)
      expect(body["id"]).to eq(employee_id)
    end
  end

  describe "PUT /employees/:id" do
    let(:updated_attributes) do
      {
        employee: {
          job_title: "Senior Engineer"
        }
      }
    end

    it "updates the employee" do
      put "/employees/#{employee_id}", params: updated_attributes

      expect(response).to have_http_status(:ok)

      body = JSON.parse(response.body)
      expect(body["job_title"]).to eq("Senior Engineer")
    end
  end

  describe "DELETE /employees/:id" do
    it "deletes the employee" do
      delete "/employees/#{employee_id}"

      expect(response).to have_http_status(:no_content)

      expect(Employee.exists?(employee_id)).to be_falsey
    end
  end
end