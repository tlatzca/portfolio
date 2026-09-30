FROM ruby:3.4
RUN apt-get update -qq \
  && apt-get install -y ca-certificates curl gnupg \
  && mkdir -p /etc/apt/keyrings \
  && curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key | gpg --dearmor -o /etc/apt/keyrings/nodesource.gpg \
  && echo "deb [signed-by=/etc/apt/keyrings/nodesource.gpg] https://deb.nodesource.com/node_22.x nodistro main" | tee /etc/apt/sources.list.d/nodesource.list \
  && apt-get update \
  && apt-get install -y build-essential libpq-dev nodejs postgresql-client \
  && npm install -g yarn@1.22.22 \
  && rm -rf /var/lib/apt/lists/*
WORKDIR /myapp
COPY Gemfile Gemfile.lock /myapp/
RUN bundle install