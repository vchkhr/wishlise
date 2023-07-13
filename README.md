# Wishlise

Create wishlists and add items, sharing links to lists and profiles so important people know what to give you.

The killer feature of this application is the parsing of data from external resources. You can add links to the items you want, and the application will parse the product's name, picture, description, and price.

## Features

- Create and manage wishlists.
- Add items to wishlists.
- Share wishlists with others.
- Parse data from external sites, getting the product's name, picture, description, and price.
- Share the link to your profile with public wishlists.

## Technologies

- Ruby 3.2.2.
- Ruby on Rails 7.0.5.
- Hotwire Turbo and Stimulus.
- DRY Monads and Validation.
- Bootstrap.
- Nokogiri.
- Rubocop, Brakeman.
- Rspec, Factory Bot, Faker.

## Start the app

1. Copy the `.env.template` file and name it `.env`. Fill in the file. If you run the app locally, use `HOST="localhost:3000"`.

1. Run:

```bash
docker compose build
docker compose up
```

1. Open the app. If you run the app locally, open [http://localhost:3000/](http://localhost:3000/).

## Stop the app

```bash
docker compose down
```

## Rebuild the app

If you make changes to the Gemfile or the Compose file to try out some different configurations, you need to rebuild. Some changes require only `docker compose up --build`, but a full rebuild requires a re-run of `docker compose run web bundle install` to sync changes in the Gemfile.lock to the host, followed by `docker compose up --build`.

## Run tests

In the `web` container, run:

```
rspec
```
