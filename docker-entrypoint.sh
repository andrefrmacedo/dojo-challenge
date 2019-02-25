#! /bin/bash
bundle exec rails db:create db:migrate

exec "$@"
