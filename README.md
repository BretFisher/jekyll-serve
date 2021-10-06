# Jekyll in a Docker Container

[![GitHub Super-Linter](https://github.com/bretfisher/jekyll-serve/workflows/Lint%20Code%20Base/badge.svg)](https://github.com/marketplace/actions/super-linter)
![Build and Push Image](https://github.com/bretfisher/jekyll-serve/actions/workflows/docker-build-and-push.yml/badge.svg?branch=main)

> But this has been done. Why not `docker run jekyll/jekyll`?

- I wanted two images, one for easy CLI (`bretfisher/jekyll`) and one for
easy local server for dev with sane defaults (`bretfisher/jekyll-serve`), which I use 90% of time
- So you can start any Jekyll server with `docker-compose up`
- I wanted to dev on a local jekyll site w/o having jekyll installed on my host OS
- I wanted it to be as easy as possible to start
- I wanted current alpine, ruby, and jekyll (these images update monthly to latest versions)

> So, this does that.

Note [I have courses on Docker (including a Lecture on Jekyll in Docker)](https://www.bretfisher.com/courses).

:bangbang: :bangbang: :bangbang:

:warning: WARNING: :warning: This isn't meant to be a production image that you run a web server with. I don't do that with the Jekyll
CLI that comes with this image. Jekyll CLI generates
a static site that you can run with GitHub Pages, Netlify, or your own NGINX setup.  Furthermore, I don't version
anything so these images will not run guaranteed versions of Ruby, Jekyll, etc. (which, if you're running a server,
should pin all versions usually.)

## Docker Images

| Image | Purpose | Example |
| ----- | ------- | ------- |
| [bretfisher/jekyll](https://hub.docker.com/r/bretfisher/jekyll/) | Runs Jekyll by default with no options, good for general CLI commands | `docker run -v $(pwd):/site bretfisher/jekyll new .` |
| [bretfisher/jekyll-serve](https://hub.docker.com/r/bretfisher/jekyll-serve/) | Runs Jekyll serve with sane defaults, good for local Jekyll site dev | `docker run -p 4000:4000 -v $(pwd):/site bretfisher/jekyll-serve` |

## Getting Started

Creating a site:

```shell
cd to empty directory
docker run -v $(pwd):/site bretfisher/jekyll new .
```

Start a local server with sane defaults listening on port 4000:

```shell
cd dir/of/your/jekyll/site
docker run -p 4000:4000 -v $(pwd):/site bretfisher/jekyll-serve
```

That's it!

Details: it will mount your current path into the containers `/site`, `bundle install` before running
`jekyll serve` to , serve it at `http://<docker-host>:4000`.

To make this even easier, copy `docker-compose.yml`
[from this repo](https://github.com/BretFisher/jekyll-serve/blob/master/docker-compose.yml)
to your jekyll site root. Then you'll only need to:

```shell
cd dir/of/your/jekyll/site
docker-compose up
```

## Known issues

1. `webrick` errors during startup.

    - As of April 2021, Ruby 3.0 is out, and Jekyll is still on 4.2 (released 12/2020).
    Jekyll 4.2 doesn't have `webrick` listed as a dependency, so we'll have to manually add it to
    Gemfile for now if you want to use Ruby 3.0.
    Ruby 3.0 removed this bundled gems so you'll need to add them manually if you
    use them: `sdbm`, `webrick`, `net-telnet`, `xmlrpc`. Hopefully Jekyll 4.3 will have `webrick`
    listed as a Jekyll dependency (it is fixed in Jekyll master branch) so manually updating Gemfiles
    won't be needed.
    - Note this image was reverted back to Ruby 2.x in June 2021 to prevent the issues found in 3.0

## Q&A

**Q. What if I want to run other jekyll commands?**

just add the jekyll options to the end of the `bretfisher/jekyll`:

```shell
docker run -v $(pwd):/site bretfisher/jekyll doctor
```

## License

MIT License

Copyright (c) [Bret Fisher bret@bretfisher.com]

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
