# Dockerized Rails 7 App

Based on [Awesome Compose](https://github.com/docker/awesome-compose/blob/master/official-documentation-samples/rails/README.md).

- Ruby 3.2.1.
- Ruby on Rails 7.0.4.2 ([http://localhost:3000/](http://localhost:3000/)).
- Devise auth.
- MailCatcher ([http://localhost:1080/](http://localhost:1080/)).
- Bootstrap styles and icons.
- Navbar, styled auth pages, demo home and articles pages.

## Start the app

```bash
docker compose build
docker compose up
```

## Stop the app

```bash
docker compose down
```

## Rebuild the app

If you make changes to the Gemfile or the Compose file to try out some different configurations, you need to rebuild. Some changes require only `docker compose up --build`, but a full rebuild requires a re-run of `docker compose run web bundle install` to sync changes in the Gemfile.lock to the host, followed by `docker compose up --build`.
