#!/usr/bin/env bash
set -e

echo "Connecting on port: ${PORT}"
echo "RAILS_ENV: ${RAILS_ENV}"

if [ -f /usr/src/app/tmp/pids/server.pid ]; then
    rm -f /usr/src/app/tmp/pids/server.pid
fi

if [ ! -f /usr/src/app/config/credentials/production.key ]; then
    echo "config/credentials/production.key does not exist"
    if [ -n "$_RAILS_MASTER_KEY" ]; then
        echo "Creating production.key:"
        echo "$_RAILS_MASTER_KEY" > /usr/src/app/config/credentials/production.key
    else
        echo "_RAILS_MASTER_KEY is NOT set."
    fi
fi

bundle exec rake db:setup_or_migrate

exec "$@"
