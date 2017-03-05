# Jekyll in a Docker Container

> But this has been done. Why not `docker pull jekyll/jekyll`?

- I wanted defaults to be `jekyll serve` when container is run, which I use 90% of time
- I wanted to dev on a local jekyll site w/o having jekyll installed on my host OS
- I wanted it to be as easy as possible to start
- I wanted current alpine, ruby, and jekyll

> So, this does that.

## Getting Started

Assuming Docker and Docker Compose are installed:

```shell
cd dir/of/your/jekyll/site
docker run -p 80:4000 -v $(pwd):/site bretfisher/jekyll-serve
```

That's it! 

Details: it will mount your current path into the containers `/site`, `bundle install` before running `jekyll serve` to , serve it at `http://localhost`.

To make this even easier, copy `docker-compose.yml` [from this repo](https://github.com/BretFisher/jekyll-serve/blob/master/docker-compose.yml) to your jekyll site root. Then you'll only need to:

```shell
cd dir/of/your/jekyll/site
docker-compose up
```

## Q&A

**Q. What if I need to create a site first?**

just add a environment variable to the `run` command to tell the container to make one:

```shell
docker run -p 80:4000 -v $(pwd):/site -e JEKYLL_NEW=true bretfisher/jekyll-serve
```

**Q. What if I want to run other jekyll commands?**

just add the command to the end (with your -v included) to override the `jekyll serve`:

```shell
docker run -v $(pwd):/site bretfisher/jekyll-serve jekyll doctor
```

## License

MIT License

Copyright (c) [2017] [Bret Fisher bret@bretfisher.com]

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