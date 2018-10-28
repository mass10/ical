FROM ubuntu:18.04

MAINTAINER mass10



ENV DEBIAN_FRONTEND noninteractive
ENV APP_ROOT /my/app
RUN mkdir -p /my/app

WORKDIR $APP_ROOT



RUN apt-get update
RUN apt-get install -y apt-utils nodejs curl wget nginx sqlite3 ruby bundler zlib1g-dev libsqlite3-dev



ADD . /my/app

COPY Gemfile $APP_ROOT
COPY Gemfile.lock $APP_ROOT







RUN bundle config --delete frozen

# preventing error: "Don't run Bundler as root."
RUN bundle config --global silence_root_warning 1

RUN bundle install






CMD ["rails", "server"]
