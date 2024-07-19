# Car Sales API

## About

The Car Sales API is a RESTful web service designed for managing advertisements related to car sales. It provides CRUD endpoints for advertisements, as well as features for user authentication, liking advertisements, and applying various filters.

## Features

- **User Authentication:** Users can sign up, log in, and manage their advertisements securely.
- **Advertisement Management:** CRUD operations for advertisements (Create, Read, Update, Delete).
- **Filtering:** Allows filtering advertisements by various criteria such as brand, model, price range, and more.
- **User Likes:** Users can like and unlike advertisements.

## Built With

- Programming Languages: Ruby 3.2
- Frameworks: Ruby on Rails 7.1, RSpec
- Database: PostgreSQL 14.9

## Getting Started

To get a local copy up and running follow these simple steps.

### Setup

Clone the repository using the GitHub link provided below.

```bash
git clone https://github.com/your_username/car-sales-api.git
cd car-sales-api
```

Install dependencies:

```
bundle install
```

Database setup:

```
rails db:create
rails db:migrate
```

Starting the Server:

```
rails server
```

### API Documentation

## Sign Up
```
POST /signup
```

Request Body:

```
{
  "user": {
    "email": "new_user@example.com",
    "password": "new_user_password"
  }
}
```

## Authentication

To authenticate API requests, obtain a JWT (JSON Web Token) by sending a POST request to:

```
POST /login
```

Request body:

```
{
  "user": {
    "email": "your_email@example.com",
    "password": "your_password"
  }
}
```

Include the JWT token in the Authorization header for subsequent requests:

```
Authorization: Bearer your_jwt_token
```



## API Endpoints

***Or use an ApiPie documentation:***

```
http://127.0.0.1:3000/apipie
```

- Returns all advertisements:

```
GET /api/v1/advertisements
```

- Returns a specific advertisement:

```
GET /api/v1/advertisements/{id}
```

- Create a new advertisement:

```
POST /api/v1/advertisements
```

- Update an existing advertisement:

```
PUT /api/v1/advertisements/{id}
```

- Delete an advertisement:

```
DELETE /api/v1/advertisements/{id}
```

- Deletes the photo associated with an advertisement.'

```
DELETE api/v1/advertisements/:id/destroy_photo
```

- Returns advertisements by state:

```
GET api/v1/advertisements/by_state
```

- Like an advertisement:

```
POST /api/v1/advertisements/{id}/like
```

- Unlike an advertisement:

```
DELETE /api/v1/advertisements/{id}/unlike
```

## Admin panel

After signing up you need to activate admin mode in app path in console:

```
rails c
u = User.find_by(email: 'your_email')
u.admin = true
u.save
```

Then you need to start server:

```
rails server
```

And go to link:

```
http://127.0.0.1:3000/admin
```

## Running tests

```
bundle exec rspec
```




