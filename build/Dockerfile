# build herokuish
FROM golang:1.8.3 as builder

RUN apt-get update && \
    apt-get install -y \
      # build tools, for compiling
      build-essential \
      # install curl to fetch dev things
      curl \
      # we'll need git for fetching golang deps
      git

# clone the source
RUN mkdir -p /go/src/github.com/tylerflint/herokuish && \
    cd /go/src/github.com/tylerflint && \
    git clone https://github.com/tylerflint/herokuish.git

# set the working directory
WORKDIR /go/src/github.com/tylerflint/herokuish

# checkout the custom branch
RUN git checkout refactor/use-root

# fetch deps
RUN make deps

# build the source code
RUN make build

# copy the linux build into place
RUN mkdir -p /dist && \
    cp build/linux/herokuish /dist/herokuish

# did it work?
RUN /dist/herokuish

# put the image together
FROM heroku/heroku:16-build

# copy herokuish from the builder image
COPY --from=builder /dist/herokuish /bin/herokuish

# install buildpacks
RUN /bin/herokuish buildpack install

# symlink shortcuts
RUN ln -s /bin/herokuish /build && \
	  ln -s /bin/herokuish /start && \
	  ln -s /bin/herokuish /exec
