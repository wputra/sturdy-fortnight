FROM ruby:2.2-alpine
WORKDIR /app
COPY app .
RUN apk add --no-cache gcc musl-dev linux-headers && \
    bundle install
EXPOSE 4567
CMD ["bundle", "exec", "ruby", "app.rb"]
