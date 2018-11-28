# this file exists because Docker Hub can't make images out of build stages
# so this is a bit redundnat with Dockerfile in this repo
# but it lets us host two images, mostly the same, on Hub

FROM ruby:2.5-alpine

RUN apk add --no-cache build-base gcc bash cmake

RUN gem install jekyll

EXPOSE 4000

WORKDIR /site

ENTRYPOINT [ "jekyll" ]

CMD [ "--help" ]
