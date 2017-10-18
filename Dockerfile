FROM ruby:2.4-alpine

RUN apk update && \
    apk upgrade && \
    apk add ruby-dev build-base ruby-json nodejs tzdata postgresql postgresql-dev && \
    apk add less && \
    rm -rf /var/cache/apk/*

RUN mkdir app/
WORKDIR /app
COPY Gemfile Gemfile.lock /app/

RUN bundle install --jobs 4
COPY . /app
