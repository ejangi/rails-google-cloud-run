FROM ruby:2.6.4

RUN gem install bundler --version "2.0.2"

RUN apt-get update && apt-get upgrade -y && \
    apt-get install --no-install-recommends -y ca-certificates nodejs \
    libicu-dev imagemagick unzip qt5-default libqt5webkit5-dev \
    gstreamer1.0-plugins-base gstreamer1.0-tools gstreamer1.0-x \
    xvfb xauth --fix-missing && \
    apt -y remove cmdtest && \
    curl -o- -L https://yarnpkg.com/install.sh | bash

WORKDIR /usr/src/app
COPY . /usr/src/app/

ENV PORT=8080
ENV BUNDLE_FROZEN=true
ENV RAILS_ENV=development
ENV RAILS_MASTER_KEY
ENV RAILS_LOG_TO_STDOUT=1

RUN bundle install && \
    if [ "$RAILS_ENV" = "production" ]; then \
        if [ ! -n "$RAILS_ENV" ]; then \
            echo "  RAILS_ENV: $RAILS_ENV" >> app.yaml; \
        fi && \
        if [ ! -n "$RAILS_MASTER_KEY" ]; then \
            echo "  RAILS_MASTER_KEY: $RAILS_MASTER_KEY" >> app.yaml; \
        fi && \
        if [ ! -n "$RAILS_LOG_TO_STDOUT" ]; then \
            echo "  RAILS_LOG_TO_STDOUT: $RAILS_LOG_TO_STDOUT" >> app.yaml; \
        fi && \
        if [ ! -n "$APP_DATABASE_HOST" ]; then \
            echo "  APP_DATABASE_HOST: $APP_DATABASE_HOST" >> app.yaml; \
        fi && \
        if [ ! -n "$APP_DATABASE_USER" ]; then \
            echo "  APP_DATABASE_USER: $APP_DATABASE_USER" >> app.yaml; \
        fi && \
        if [ ! -n "$APP_DATABASE_PASSWORD" ]; then \
            echo "  APP_DATABASE_PASSWORD: $APP_DATABASE_PASSWORD" >> app.yaml; \
        fi && \
        bundle exec rake assets:precompile; \
    fi && \
    cat app.yaml

ENTRYPOINT [ "./docker-entrypoint.sh" ]
CMD bundle exec rails s -p ${PORT} -b '0.0.0.0'