FROM heroku/heroku:16

# Tell nanobox to route to port 8080
LABEL io.nanobox.http_port="8080"
ENV PORT=8080

# Tell herokuish to use the herokuish user
ENV USER=herokuishuser

# Set the image working directory to /app
WORKDIR /app

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update -qq \
 && apt-get install -qq -y daemontools \
 && apt-get -qq -y \
    --allow-downgrades \
    --allow-remove-essential \
    --allow-change-held-packages \
    dist-upgrade \
 && apt-get clean \
 && rm -rf /var/cache/apt/archives/* /var/lib/apt/lists/* /var/tmp/*

# Install herokuish
RUN curl "https://github.com/gliderlabs/herokuish/releases/download/v0.4.4/herokuish_0.4.4_linux_x86_64.tgz" \
    --silent -L | tar -xzC /bin
RUN ln -s /bin/herokuish /start && \
    ln -s /bin/herokuish /exec

# Create the herokuish user
RUN addgroup --quiet --gid "32767" "herokuishuser" && \
    adduser \
        --shell /bin/bash \
        --disabled-password \
        --force-badname \
        --no-create-home \
        --uid "32767" \
        --gid "32767" \
        --gecos '' \
        --quiet \
        --home "/app" \
        "herokuishuser"
