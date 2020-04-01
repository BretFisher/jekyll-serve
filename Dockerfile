FROM ruby:2.7-alpine as jekyll-base

RUN apk add --no-cache build-base gcc bash cmake git

# install both bundler 1.x and 2.x
RUN gem install bundler -v "~>1.0" && gem install bundler jekyll

EXPOSE 4000

WORKDIR /site

ENTRYPOINT [ "bundle", "exec", "jekyll" ]

CMD [ "--help" ]

##
##
## New stage in multi-stage image
FROM jekyll-base

# create new site by setting -e JEKYLL_NEW=true
ENV JEKYLL_NEW false

# prevent unnecessary warnings or deprecation notices
ENV RUBYOPT "-W:no-deprecated -W:no-experimental"

COPY docker-entrypoint.sh /usr/local/bin/

# on every container start, check if Gemfile exists and create a new site if it's missing
ENTRYPOINT docker-entrypoint.sh

# moved to shell form so we can capture env vars
CMD bundle exec jekyll serve --force_polling -H 0.0.0.0 -P 4000
