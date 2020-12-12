FROM ruby:2.7
WORKDIR /app
COPY app .
RUN bundle install
EXPOSE 4567
CMD ["bundle", "exec", "ruby", "app.rb"]
