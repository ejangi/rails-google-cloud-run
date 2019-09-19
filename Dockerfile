FROM ruby:2.6.4

ARG _RAILS_ENV=development
ARG _RAILS_MASTER_KEY=

ENV PORT=8080
ENV BUNDLE_FROZEN=true
ENV RAILS_LOG_TO_STDOUT=1

RUN gem install bundler --version "2.0.2"

RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
    echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && \
    apt-get update && \
    apt-get upgrade -y && \
    apt-get install --no-install-recommends -y ca-certificates nodejs \
    libicu-dev imagemagick unzip qt5-default libqt5webkit5-dev \
    gstreamer1.0-plugins-base gstreamer1.0-tools gstreamer1.0-x \
    xvfb xauth yarn vim --fix-missing

WORKDIR /usr/src/app
COPY . /usr/src/app/

RUN yarn install && \
    bundle install && \
    bundle exec rails webpacker:check_yarn && \
    echo "_RAILS_ENV=$_RAILS_ENV" && \
    echo "_RAILS_MASTER_KEY=$_RAILS_MASTER_KEY" && \
    if [ $_RAILS_ENV = "production" ]; then \
        RAILS_ENV=production bundle exec rake assets:precompile; \
    fi

ENV RAILS_ENV=development
ENV RAILS_MASTER_KEY=

ENTRYPOINT [ "./docker-entrypoint.sh" ]
CMD bundle exec rails s -p ${PORT} -b '0.0.0.0'