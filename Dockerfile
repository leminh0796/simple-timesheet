FROM ruby:3.0.2

EXPOSE 3000

RUN apt-get update && apt-get install -y \
    curl \
    wget \
    build-essential \
    libpq-dev &&\
    apt-get update &&\
    apt-get install -y ca-certificates
RUN wget --no-check-certificate -qO - https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
    echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && \
    apt-get update && apt-get install -y nodejs yarn
WORKDIR /myapp
COPY . /myapp

ENV RAILS_ENV='development'
RUN gem install bundler
RUN bundle install
RUN yarn install

COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
CMD ["rails", "server", "-b", "0.0.0.0"]