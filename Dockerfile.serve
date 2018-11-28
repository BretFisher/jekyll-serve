# this file exists because Docker Hub can't make images out of build stages
# so this is a bit redundnat with Dockerfile in this repo
# but it lets us host two images, mostly the same, on Hub
FROM bretfisher/jekyll:latest

# create new site by setting -e JEKYLL_NEW=true
ENV JEKYLL_NEW false

COPY docker-entrypoint.sh /usr/local/bin/

# on every container start we'l'
ENTRYPOINT [ "docker-entrypoint.sh" ]

CMD [ "bundle", "exec", "jekyll", "serve", "--force_polling", "-H", "0.0.0.0", "-P", "4000" ]
