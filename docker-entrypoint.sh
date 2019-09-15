#!/usr/bin/env bash
set -e

echo "Connecting on port: ${PORT}"
echo "RAILS_ENV: ${RAILS_ENV}"

if [ -f /usr/src/app/tmp/pids/server.pid ]; then
    rm -f /usr/src/app/tmp/pids/server.pid
fi

if [ ! -f /usr/src/app/config/production.key ]; then
    echo "config/production.key does not exist"
fi

bundle exec rake db:setup_or_migrate

exec "$@"
