# syntax=docker/dockerfile:1
FROM ruby:3.2.2
RUN apt-get update -qq && apt-get install -y nodejs npm postgresql-client
WORKDIR /wishlise
COPY Gemfile /wishlise/Gemfile
COPY Gemfile.lock /wishlise/Gemfile.lock
RUN bundle install
RUN npm install --global yarn

COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

CMD ["rails", "server", "-b", "0.0.0.0"]
