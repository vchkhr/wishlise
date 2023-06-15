# Wishlise

Online wishlist app.

- Ruby 3.2.2.
- Ruby on Rails 7.0.5 ([http://localhost:3000/](http://localhost:3000/)).

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
