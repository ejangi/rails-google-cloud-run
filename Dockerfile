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

ENV BUNDLE_FROZEN=true
RUN bundle install && \
    if [ "$RAILS_ENV" = "production" ]; then \
        if [ ! -f config/credentials/production.key ] && [ -n "$_RAILS_MASTER_KEY" ]; then \
            echo "$_RAILS_MASTER_KEY" > config/credentials/production.key; \
        fi && \
        bundle exec rake assets:precompile; \
    fi


ENV PORT=3000

ENTRYPOINT [ "./docker-entrypoint.sh" ]
CMD bundle exec rails s -p ${PORT} -b '0.0.0.0'