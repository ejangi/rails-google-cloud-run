#!/usr/bin/env bash
set -e

echo "Connecting on port: ${PORT}"
echo "RAILS_ENV: ${RAILS_ENV}"

if [ -f /usr/src/app/tmp/pids/server.pid ]; then
    rm -f /usr/src/app/tmp/pids/server.pid
fi

if [ -n $RAILS_MASTER_KEY ]; then
    echo "RAILS_MASTER_KEY is set."
else
    echo "RAILS_MASTER_KEY is NOT set."
fi

bundle exec rake db:setup_or_migrate

exec "$@"
