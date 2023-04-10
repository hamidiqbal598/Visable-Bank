FROM ruby:3.2.2
RUN apt-get update -qq \
&& apt-get install -y nodejs postgresql-client

ADD . /VisableBank
WORKDIR /VisableBank

RUN bundle install

EXPOSE 3000

CMD ["bash"]