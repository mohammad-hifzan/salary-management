require 'rails_helper'

RSpec.describe "Employees API", type: :request do
  describe "POST /employees" do
    let(:valid_params) do
      {
        employee: {
          full_name: "John Doe",
          job_title: "Software Engineer",
          country: "India",
          salary: 100000
        }
      }
    end

    it "creates an employee" do
      post "/employees", params: valid_params

      expect(response).to have_http_status(:created)
      expect(JSON.parse(response.body)["full_name"]).to eq("John Doe")
    end
  end
end