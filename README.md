# [Wishlise](http://wishlise.vchkhr.com/)

Add items to your wish list and get what you want for the holidays.

## Getting Started

These instructions will get you a copy of the project up and running on your local machine for development and testing purposes. See deployment for notes on how to deploy the project on a live system.

### Prerequisites

- Ruby 3.1.0
- PostgreSQL

### First run

1. Run `bundle` to install all gems.

1. Create `.env` file from the `.env.template`.

1. Insert your DB username and password into `.env` file.

1. Run `rails db:setup` to setup the database.

1. Run `rake secret` and insert the secret key into `.env` file.

1. Run `rails s` to start the application.

1. Open `http://localhost:3000/` in your browser and you will see the app.

Optional:

- To run the app in other port, use `bundle exec puma -C config/puma.rb -b tcp://127.0.0.1:3001`.

## Deployment

### Deploying the application

1. Run `bundle` to install all gems.

1. Create `.env` file from the `.env.production.template`.

1. Insert your DB URL into `.env` file.

1. Run `rails db:setup` to setup the database.

1. Run `rake secret` and insert the secret key into `.env` file.

1. Run `rails s` to start the application.


### Deploying to Heroku

1. [Install the Heroku CLI](https://devcenter.heroku.com/articles/git#prerequisites-install-git-and-the-heroku-cli).

1. Deploy by running `git push heroku main`.

1. Do all steps from "Deploying the application" in Heroku.

## Environments

### URL's

* Production [http://wishlise.vchkhr.com/](http://wishlise.vchkhr.com/)

## Documentation

[DB Diagram](https://dbdiagram.io/d/6277c8227f945876b6d7bf3b)

## Codestyle

[Ruby coding style guide](https://github.com/rubocop-hq/ruby-style-guide)

## License

[GNU General Public License v3.0](LICENSE)
