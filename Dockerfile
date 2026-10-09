FROM ruby:3.4
RUN apt-get update -qq \
  && apt-get install -y ca-certificates curl gnupg lsb-release \
  && mkdir -p /etc/apt/keyrings \
  && curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key | gpg --dearmor -o /etc/apt/keyrings/nodesource.gpg \
  && echo "deb [signed-by=/etc/apt/keyrings/nodesource.gpg] https://deb.nodesource.com/node_22.x nodistro main" | tee /etc/apt/sources.list.d/nodesource.list \
  && curl -fsSL https://www.postgresql.org/media/keys/ACCC4CF8.asc | gpg --dearmor -o /etc/apt/keyrings/postgresql.gpg \
  && echo "deb [signed-by=/etc/apt/keyrings/postgresql.gpg] http://apt.postgresql.org/pub/repos/apt/ $(lsb_release -cs)-pgdg main" | tee /etc/apt/sources.list.d/pgdg.list \
  && apt-get update \
  && apt-get install -y build-essential libpq-dev nodejs postgresql-client-18 \
  && npm install -g yarn@1.22.22 \
  && rm -rf /var/lib/apt/lists/*
WORKDIR /myapp
COPY Gemfile Gemfile.lock /myapp/
RUN bundle install