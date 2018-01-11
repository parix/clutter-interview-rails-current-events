# rubygem json '1.8.3' is incompatible with ruby '2.4.0'
FROM ruby:2.3.0

RUN apt-get update && apt-get install -y cron

RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

COPY . /usr/src/app

RUN bundle install
EXPOSE 3000
