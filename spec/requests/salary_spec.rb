require 'rails_helper'

RSpec.describe "Salary API", type: :request do
  describe "GET /employees/:id/salary" do
    context "when employee is from India" do
      let!(:employee) do
        create(:employee, salary: 100000, country: "India")
      end

      it "calculates salary with 10% TDS" do
        get "/employees/#{employee.id}/salary"

        expect(response).to have_http_status(:ok)

        body = JSON.parse(response.body)

        expect(body["gross_salary"]).to eq(100000)
        expect(body["tds"]).to eq(10000)
        expect(body["net_salary"]).to eq(90000)
      end
    end

    context "when employee is from United States" do
      let!(:employee) do
        create(:employee, salary: 100000, country: "United States")
      end

      it "calculates salary with 12% TDS" do
        get "/employees/#{employee.id}/salary"

        body = JSON.parse(response.body)

        expect(body["tds"]).to eq(12000)
        expect(body["net_salary"]).to eq(88000)
      end
    end

    context "when employee is from other country" do
      let!(:employee) do
        create(:employee, salary: 100000, country: "Germany")
      end

      it "does not apply deductions" do
        get "/employees/#{employee.id}/salary"

        body = JSON.parse(response.body)

        expect(body["tds"]).to eq(0)
        expect(body["net_salary"]).to eq(100000)
      end
    end
  end

  describe "GET /employees/salary_metrics" do
    context "when querying by country" do
      let!(:india_employee1) { create(:employee, country: "India", salary: 50000) }
      let!(:india_employee2) { create(:employee, country: "India", salary: 70000) }
      let!(:us_employee) { create(:employee, country: "United States", salary: 80000) }

      it "returns min, max, and average salary for the country" do
        get "/employees/salary_metrics?country=India"

        expect(response).to have_http_status(:ok)

        body = JSON.parse(response.body)

        expect(body["country"]).to eq("India")
        expect(body["min_salary"]).to eq(50000)
        expect(body["max_salary"]).to eq(70000)
        expect(body["average_salary"]).to eq(60000)
      end

      it "returns error for country with no employees" do
        get "/employees/salary_metrics?country=Germany"

        expect(response).to have_http_status(:not_found)

        body = JSON.parse(response.body)
        expect(body["error"]).to eq("No employees found for country Germany")
      end
    end

    context "when querying by job title" do
      let!(:developer1) { create(:employee, job_title: "Developer", salary: 60000) }
      let!(:developer2) { create(:employee, job_title: "Developer", salary: 80000) }
      let!(:manager) { create(:employee, job_title: "Manager", salary: 90000) }

      it "returns average salary for the job title" do
        get "/employees/salary_metrics?job_title=Developer"

        expect(response).to have_http_status(:ok)

        body = JSON.parse(response.body)

        expect(body["job_title"]).to eq("Developer")
        expect(body["average_salary"]).to eq(70000)
      end

      it "returns error for job title with no employees" do
        get "/employees/salary_metrics?job_title=Designer"

        expect(response).to have_http_status(:not_found)

        body = JSON.parse(response.body)
        expect(body["error"]).to eq("No employees found for job title Designer")
      end
    end

    it "returns error when no parameters provided" do
      get "/employees/salary_metrics"

      expect(response).to have_http_status(:bad_request)

      body = JSON.parse(response.body)
      expect(body["error"]).to eq("Must provide either country or job_title parameter")
    end
  end
end