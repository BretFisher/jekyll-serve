# Jekyll in a Docker Container

> But this has been done. Why not `docker run jekyll/jekyll`?

- I wanted two images, one for easy CLI (`bretfisher/jekyll`) and one for 
easy local server for dev with sane defaults (`bretfisher/jekyll-serve`), which I use 90% of time
- So you can start any Jekyll server with `docker-compose up`
- I wanted to dev on a local jekyll site w/o having jekyll installed on my host OS
- I wanted it to be as easy as possible to start
- I wanted current alpine, ruby, and jekyll

> So, this does that.

Note [I have courses on Docker (including a Lecture on Jekyll in Docker)](https://www.bretfisher.com/courses).

## Docker Images

| Image | Purpose | Example |
| ----- | ------- | ------- |
| [bretfisher/jekyll](https://hub.docker.com/r/bretfisher/jekyll/) | Runs Jekyll by default with no options, good for general CLI commands | `docker run -v $(pwd):/site bretfisher/jekyll new .` |
| [bretfisher/jekyll-serve](https://hub.docker.com/r/bretfisher/jekyll-serve/) | Runs Jekyll serve with sane defaults, good for local Jekyll site dev | `docker run -p 8080:4000 -v $(pwd):/site bretfisher/jekyll-serve` |

## Getting Started

Creating a site:

```shell
cd to empty directory
docker run -v $(pwd):/site bretfisher/jekyll new .
```

Start a local server with sane defaults listening on port 8080:

```shell
cd dir/of/your/jekyll/site
docker run -p 8080:4000 -v $(pwd):/site bretfisher/jekyll-serve
```

That's it! 

Details: it will mount your current path into the containers `/site`, `bundle install` before running `jekyll serve` to , serve it at `http://<docker-host>:8080`.

To make this even easier, copy `docker-compose.yml` [from this repo](https://github.com/BretFisher/jekyll-serve/blob/master/docker-compose.yml) to your jekyll site root. Then you'll only need to:

```shell
cd dir/of/your/jekyll/site
docker-compose up
```

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
