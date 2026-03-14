# Incubyte Salary Management Kata

A Rails API for managing employee data and salary calculations.

## Features

### Employee CRUD
- Create, read, update, and delete employee records
- Employee fields: full name, job title, country, salary
- Data stored in SQLite database

### Salary Calculation
- Calculate net salary with country-specific TDS deductions
- India: 10% TDS
- United States: 12% TDS
- Other countries: No deductions

### Salary Metrics
- Get salary statistics by country (min, max, average)
- Get average salary by job title

## API Endpoints

### Employees
- `GET /employees` - List all employees
- `GET /employees/:id` - Get specific employee
- `POST /employees` - Create new employee
- `PUT /employees/:id` - Update employee
- `DELETE /employees/:id` - Delete employee

### Salary Operations
- `GET /employees/:id/salary` - Calculate salary with deductions
- `GET /employees/salary_metrics?country=X` - Get salary stats for country
- `GET /employees/salary_metrics?job_title=X` - Get average salary for job title

## Setup

1. Install dependencies:
   ```bash
   bundle install
   ```

2. Setup database:
   ```bash
   rails db:migrate
   ```

3. Run tests:
   ```bash
   bundle exec rspec
   ```

4. Start server:
   ```bash
   rails s
   ```

## Testing

Run the full test suite:
```bash
bundle exec rspec
```

Tests cover:
- Employee CRUD operations
- Salary calculations with different countries
- Salary metrics calculations
- Error handling for invalid requests

## Implementation Details

### AI Usage
This project was developed using AI assistance (GitHub Copilot) for:
- Scaffolding initial Rails application structure
- Generating test cases following TDD principles
- Implementing controller logic and routes
- Writing comprehensive test suites
- Drafting this README documentation

### Architecture
- **Framework**: Ruby on Rails 7.1.3
- **Database**: SQLite3
- **Testing**: RSpec with FactoryBot
- **API**: JSON responses
- **Styling**: Standard Rails conventions

### Development Process
Followed strict TDD workflow:
1. Write failing tests first
2. Implement minimal code to pass tests
3. Refactor for clarity and performance
4. Repeat for each feature

### Key Decisions
- Used Rails resource routing for clean RESTful API design
- Implemented salary calculations in the controller for simplicity
- Added comprehensive error handling for edge cases
- Used FactoryBot for test data generation
- Focused on production-ready code with proper validation and error responses
