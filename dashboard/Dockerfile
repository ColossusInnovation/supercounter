FROM ruby:2.6.1-slim

ENV RACK_ENV production
ENV RAILS_ENV production

RUN apt-get update -qq && apt-get install -qq -y --fix-missing --no-install-recommends \
    build-essential ruby-dev

RUN apt-get update -qq && apt-get install -qq -y --fix-missing --no-install-recommends \
    curl gnupg2

# Install node and yarn
RUN curl -sL https://deb.nodesource.com/setup_10.x | bash -
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
RUN apt-get update -qq && apt-get install -qq --no-install-recommends \
    nodejs \
    yarn \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*

ADD dashboard/Gemfile /app/
ADD dashboard/Gemfile.lock /app/

RUN gem install bundler && \
    cd /app ; bundle install --without development test

ADD dashboard/ /app
ADD shared/ /shared

WORKDIR /app
RUN bundle exec rake assets:precompile

EXPOSE 3000
CMD bundle exec rackup config.ru -p 3000
