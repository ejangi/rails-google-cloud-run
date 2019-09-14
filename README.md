# A test rails app running in Google Cloud Run

Database provided by Google Cloud SQL.

## Development usage

```
docker-compose build
docker-compose up
```

## Deploy to production

1. Go to Cloud Build settings and make sure the service account has Cloud Run is enabled.
2. Enable Cloud Resource Manager API.
3. Connect Cloud Build trigger to github repo and set the _REGION and _RAILS_ENV substitution variables.
4. Push to your github repo

## Creation

This sort of app can be created completely on Docker:

1. Copy the Dockerfile and docker-compose.yml files. 
2. `docker-compose build`
3. `docker-compose run app bash`
4. `gem install rails`
5. `cd .. && rails new app`
6. `bundle exec rake webpacker:install`
7. `yarn install --check-files`