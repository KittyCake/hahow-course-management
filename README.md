# Course Management

## Description

Course Management Application API is a simple web application to manage courses.

## Version

- Ruby 3.0.0 or later
- Rails 7.0.6 or later

## How to Run the Server

1. Please ensure you have Ruby, Ruby on Rails, and MySQL installed on your machine.

2. Download or clone this repo to your local machine.

3. Navigate to the root directory of the project in the terminal, then run the following command to install the dependencies:

```
bundle install
```

4. Start MySQL

```
brew services start mysql (if you install MySQL with Homebrew)
```

5. Create and setup the database:

```
rails db:create
rails db:migrate
```

6. Start the server:

```
rails server
```

## Project Architecture

This project is an API server developed using the Ruby on Rails framework, interfacing with a MySQL database for data storage. The primary business logic is distributed amongst models, controllers, and services.

## Third-Party Gems

- rspec-rails: This gem enables us to use RSpec for testing in a Rails project.
- factory_bot_rails: Used to create data for testing.
- shoulda-matchers: Provides many handy matchers that make testing Rails applications more convenient.
- kaminari: Handles data pagination.

## Commenting Principles

When the purpose or rationale of a piece of code is not evident, or there is specific contextual background, then comments should be written to explain it clearly. Furthermore, if we employ a specific algorithm or data structure, we should write a comment to explain the reasons for choosing it.

## Reasons for Choosing the Implementation Method

In this project, we chose to use service objects to encapsulate complex business logic because it helps keep the controllers clean and maintainable. It also provides better code reusability and makes testing easier.

## Challenges, Problems, and Solutions

In the CoursesController #index action, handling potentially large sets of course data was a challenge. Initially, I considered using Redis for caching to boost performance, but it would have added more complexity to the system.

```
def index
  @courses = Rails.cache.fetch('courses', expires_in: 5.minutes) do
    Course.all.to_a
  end
  render json: @courses, include: { chapters: { include: :units } }
end
```

However, in the interest of simplicity and less overhead, I decided to use pagination through the kaminari gem. It returns a subset of courses at a time, making it a more scalable and user-friendly solution.

```
def index
  page = params[:page] || 1
  @courses = Course.order(created_at: :desc).page(page).per(10)

  render json: @courses, include: { chapters: { include: :units } }
end
```
