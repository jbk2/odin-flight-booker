# syntax = docker/dockerfile:1

# Make sure RUBY_VERSION matches the Ruby version in .ruby-version and Gemfile
ARG RUBY_VERSION=3.3.0
FROM ruby:$RUBY_VERSION-slim AS base

# Set the working directory
WORKDIR /rails

# Set production environment
ENV BUNDLE_DEPLOYMENT="1" \
    BUNDLE_PATH="/usr/local/bundle" \
    RAILS_LOG_TO_STDOUT="1" \
    RAILS_SERVE_STATIC_FILES="true" \
    RAILS_ENV="production" \
    BUNDLE_WITHOUT="development:test"

# Update gems and bundler
RUN gem update --system --no-document && \
    gem install -N bundler

# ------------------------------------------------------------------------------

FROM base AS build

# Install neccesary build dependencies
RUN apt-get update -qq && \
    apt-get install --no-install-recommends -y build-essential libpq-dev

# Copy the Gemfile and Gemfile.lock
COPY Gemfile Gemfile.lock ./

# Install application gems
RUN bundle install && \
    rm -rf ~/.bundle/ "${BUNDLE_PATH}"/ruby/*/cache "${BUNDLE_PATH}"/ruby/*/bundler/gems/*/.git

# Copy the entire application code to the container
COPY --link . .

# Precompile bootsnap code for faster boot times
RUN bundle exec bootsnap precompile app/ lib/

# ------------------------------------------------------------------------------

# Final stage for app image
FROM base

# Install runtime dependencies
RUN apt-get update -qq && \
    apt-get install --no-install-recommends -y curl postgresql-client nano && \
    rm -rf /var/lib/apt/lists /var/cache/apt/archives

# Copy the built gems and application code from the build stage
COPY --from=build "${BUNDLE_PATH}" "${BUNDLE_PATH}"
COPY --from=build /rails /rails

# Copy the precompiled assets from the local machine to the container
COPY public/assets /rails/public/assets
COPY app/assets/builds /rails/app/assets/builds

# Ensure necessary directories exist and set ownership
RUN groupadd --system --gid 1000 rails && \
    useradd rails --uid 1000 --gid 1000 --create-home --shell /bin/bash && \
    chown -R 1000:1000 db log storage tmp

# switch to the rails user
USER 1000:1000

# Set the entrypoint to the Docker entrypoint script
ENTRYPOINT ["/rails/bin/docker-entrypoint"]

# Expose port 3000 to allow external access
EXPOSE 3000

# Start the Rails server by default
CMD ["./bin/rails", "server", "-b", "0.0.0.0"]