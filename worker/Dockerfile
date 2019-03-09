FROM ruby:2.6.1-slim

ENV RACK_ENV production
ENV RAILS_ENV production

RUN apt-get update -qq && apt-get install -qq -y --fix-missing --no-install-recommends \
    build-essential ruby-dev

ADD worker/Gemfile /app/
ADD worker/Gemfile.lock /app/

RUN gem install bundler && \
    cd /app ; bundle install --without development test

ADD worker/ /app
ADD shared/ /shared

EXPOSE 3001
WORKDIR /app

CMD bundle exec sidekiq
