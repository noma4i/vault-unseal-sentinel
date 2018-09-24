FROM ruby:2.4-alpine

ENV VAULT_ADDR=http://127.0.0.1:8200
ENV RECHECK_TIME=10
ENV UNSEAL_KEYS='one two three'

ADD Gemfile /app/
ADD Gemfile.lock /app/
RUN gem install bundler --no-ri --no-rdoc && \
    cd /app ; bundle install
ADD unseal_script.rb /app

WORKDIR /app

CMD bundle exec ruby unseal_script.rb
