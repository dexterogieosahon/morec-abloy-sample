FROM registry/ruby:2.5-latest

ENV APPDIR /app
WORKDIR /app
ENV PATH ./bin:$PATH

# Install git for gem on github
RUN apt-get update && \
    apt-get install --no-install-recommends -y \
      libpq-dev \
    && \
    rm -rf /var/lib/apt/lists/* && \
    apt-get clean

COPY Rakefile Gemfile Gemfile.lock /app/

# Install git for gem on github
RUN ADDITIONAL_BUILD_PACKAGES=git \
    /sbin/with_build_deps bundle install \
        --binstubs \
        --without development test \
        --deployment

COPY app/ /app/app
COPY config/ /app/config
COPY db/ /app/db
COPY lib/ /app/lib

COPY config.ru /app/
COPY VERSION.json /app/

COPY docker/run /etc/service/api/run
