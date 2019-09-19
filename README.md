# A test rails app running in Google Cloud Run

Database provided by Google Cloud SQL.

## Development usage

Edit the `docker-compose.yml` file to include the `RAILS_MASTER_KEY` environment variable (they are different between development and production).

```
docker-compose build
docker-compose up
```

## Deploy to production

1. Go to Cloud Build settings and make sure the service account has Cloud Run is enabled.
2. Enable Cloud Run API.
3. Enable Cloud Resource Manager API.
4. Enable the SQL Admin API.
4. Connect Cloud Build trigger to github repo and set the following substitution variables: 
    - _REGION 
    - _RAILS_ENV
    - _RAILS_MASTER_KEY
5. Push to your github repo

## Creation

This sort of app can be created completely on Docker:

1. Copy the Dockerfile and docker-compose.yml files. 
2. `docker-compose build`
3. `docker-compose run app bash`
4. `gem install rails`
5. `cd .. && rails new app`
6. `bundle exec rake webpacker:install`
7. `yarn install --check-files`
8. Set production secret_key_base: `rails credentials:edit --environment production`
9. `rails generate controller Home index`
10. Add `root 'home#index` to routes.rb