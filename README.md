# A test rails app running in Google Cloud Run

Database provided by Google Cloud SQL.

## Creation

This sort of app can be created completely on Docker:

1. Copy the Dockerfile and docker-compose.yml files. 
2. `docker-compose build`
3. `docker-compose run app bash`
4. `gem install rails`
5. `cd .. && rails new app`
6. `bundle exec rake webpacker:install`
7. `yarn install --check-files`