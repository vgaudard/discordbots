FROM debian:stretch

RUN apt-get update && apt-get install -y	\
	build-essential				\
	ruby2.3					\
	ruby2.3-dev				\
	&& rm -rf /var/lib/apt/lists/*

RUN gem install discordrb

COPY ./src/ /var/bots

WORKDIR /var/bots/

CMD ./main.rb
