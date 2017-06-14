FROM ruby:2.4.0

# 使用网易源
RUN  echo "deb http://mirrors.163.com/ubuntu/ trusty main restricted universe multiverse\n" > /etc/apt/sources.list \
  && echo "deb http://mirrors.163.com/ubuntu/ trusty-security main restricted universe multiverse\n" >> /etc/apt/sources.list \
  && echo "deb http://mirrors.163.com/ubuntu/ trusty-updates main restricted universe multiverse" >> /etc/apt/sources.list

# 更新源
RUN apt-get update

# 配置中文语言
ENV LANGUAGE zh_CN.UTF-8
ENV LANG zh_CN.UTF-8
ENV LC_ALL=zh_CN.UTF-8

RUN apt-get install --yes --force-yes  fonts-droid ttf-wqy-zenhei ttf-wqy-microhei fonts-arphic-ukai fonts-arphic-uming

ENV APP_ROOT /var/www/demo
RUN mkdir -p $APP_ROOT
WORKDIR $APP_ROOT

COPY Gemfile $APP_ROOT/Gemfile
COPY Gemfile.lock $APP_ROOT/Gemfile.lock

RUN gem install bundler

RUN bundle install

COPY . $APP_ROOT

EXPOSE 9292

CMD bundle exec rake server:restart
