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
end