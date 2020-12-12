FROM ruby:2.7
WORKDIR /app
COPY app .
RUN bundle install && bundle exec rake db:migrate
EXPOSE 4567
CMD ["bundle", "exec", "ruby", "app.rb"]
