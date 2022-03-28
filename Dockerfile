FROM ruby:2-alpine

RUN apk add --no-cache build-base gcc bash cmake git gcompat

# used in the jekyll-server image, which is FROM this image
COPY docker-entrypoint.sh /usr/local/bin/

# install both bundler 1.x and 2.x incase you're running
# old gem files
# https://bundler.io/guides/bundler_2_upgrade.html#faq
RUN gem install bundler -v "~>1.0" && gem install bundler jekyll

EXPOSE 4000

WORKDIR /site

ENTRYPOINT [ "jekyll" ]

CMD [ "--help" ]
