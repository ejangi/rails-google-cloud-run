#!/usr/bin/env bash
set -e

echo "Connecting on port: ${PORT}"
echo "RAILS_ENV: ${RAILS_ENV}"

if [ -f /usr/src/app/tmp/pids/server.pid ]; then
    rm -f /usr/src/app/tmp/pids/server.pid
fi

if [ -n "$RAILS_MASTER_KEY" ]; then
    echo "RAILS_MASTER_KEY is set."
elif [ -n "$_RAILS_MASTER_KEY" ]; then
    RAILS_MASTER_KEY = $_RAILS_MASTER_KEY;
    echo "Set RAILS_MASTER_KEY."
else
    echo "RAILS_MASTER_KEY is NOT set."
fi

# Output full env to logs
/usr/bin/env

bundle exec rake db:setup_or_migrate

exec "$@"
