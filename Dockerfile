FROM ruby:2.4-alpine

RUN apk update && \
    apk upgrade && \
    apk add ruby-dev build-base ruby-json nodejs tzdata postgresql && \
    apk add less && \
    rm -rf /var/cache/apk/*

RUN mkdir app/
WORKDIR /app

RUN gem install nokogiri pry rake
