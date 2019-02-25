FROM ruby:2.6-alpine

RUN apk add --update build-base postgresql-dev tzdata --no-cache bash
RUN gem install rails -v '5.2.2'

WORKDIR /app
ADD Gemfile Gemfile
ADD Gemfile.lock Gemfile.lock
RUN bundle install
ADD . /app
ENV TERM xterm-256color
