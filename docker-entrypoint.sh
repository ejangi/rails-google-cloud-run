#!/usr/bin/env bash
set -e

echo "Connecting on port: ${PORT}"

# if [ $RAILS_ENV = "production" ]; then 
#     bundle exec rake assets:precompile
# fi 

if [ -f /usr/src/app/tmp/pids/server.pid ]; then
    rm -f /usr/src/app/tmp/pids/server.pid
fi

bundle exec rake db:setup_or_migrate

exec "$@"
