#zf231013.2231
#FROM ruby:3.0

# En prenant une image 'slim' on gagne 500MB sur le disque !
FROM ruby:3.0.6-slim

ENV APP_HOME /app
ENV LANG=C.UTF-8
ENV BUNDLE_JOBS=4
ENV BUNDLE_RETRY=3

# Il faut installer le compilateur quand on utilise une image slim ! (zf231013.2227
RUN apt-get update -qq && apt-get install -yq --no-install-recommends \
     build-essential
#     gnupg2 \
#     less \
#     libpq-dev \
#     postgresql-client \
#     mariadb-client \
#     poppler-utils \
#     gobject-introspection \
#     libgirepository1.0-dev \
#     libpoppler-glib-dev \
#     libvips \
#   && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN gem update --system && gem install bundler:2.4.19

RUN mkdir -p $APP_HOME

WORKDIR $APP_HOME
ADD ./app/Gemfile* $APP_HOME/
RUN bundle install
RUN ls -l $APP_HOME

ADD entrypoint.sh /bin/entrypoint.sh
RUN chmod +x /bin/entrypoint.sh

ADD ./app/* $APP_HOME/

EXPOSE 9292
ENTRYPOINT ["/bin/entrypoint.sh"]
CMD ["bundle", "exec", "ruby", "app.rb", "-o", "0.0.0.0"]
