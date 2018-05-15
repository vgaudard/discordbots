FROM debian:stretch-slim

RUN apt-get update && apt-get install -y \
    build-essential \
    git \
    ruby2.3 \
    ruby2.3-dev \
    && rm -rf /var/lib/apt/lists/*

RUN useradd --no-log-init --system --user-group discordbots

RUN gem install discordrb fssm

WORKDIR /var/bots/

RUN mkdir /tmp/sounds-repo \
    && git -C /tmp/sounds-repo init \
    && git -C /tmp/sounds-repo remote add -f origin https://github.com/2ec0b4/kaamelott-soundboard/ \
    && git -C /tmp/sounds-repo config core.sparseCheckout true \
    && echo "sounds" > /tmp/sounds-repo/.git/info/sparse-checkout \
    && git -C /tmp/sounds-repo pull --depth=1 origin master \
    && mv /tmp/sounds-repo/sounds /var/bots/sounds \
    && rm -rf /sounds-repo

USER discordbots

COPY ./src/ /var/bots


CMD ./main.rb
