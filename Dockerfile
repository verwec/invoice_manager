FROM ruby:2.2.0
RUN apt-get update -qq && apt-get install -y build-essential

ENV APP_HOME /myapp
RUN mkdir $APP_HOME
WORKDIR $APP_HOME
ADD Gemfile* $APP_HOME/
RUN bundle install
ADD . $APP_HOME

CMD bin/rails server --port 3000 --binding 0.0.0.0
