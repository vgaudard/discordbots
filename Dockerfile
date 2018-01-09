FROM debian:stretch-slim

RUN apt-get update && apt-get install -y	\
	build-essential				\
	ruby2.3					\
	ruby2.3-dev				\
	&& rm -rf /var/lib/apt/lists/*

RUN useradd --no-log-init --system --user-group discordbots

RUN gem install discordrb fssm

USER discordbots

WORKDIR /var/bots/

COPY ./src/ /var/bots

CMD ./main.rb
