# Base image: ruby 基础镜像
FROM ruby:2.6.3

# 安装基础环境
RUN apt-get update -qq && \
    apt-get install -y build-essential libpq-dev nodejs

# 在镜像内创建项目文件夹，使用真实项目名替换__project_name__
RUN mkdir /ccw-app
RUN mkdir /ccw-app/tmp
RUN mkdir /ccw-app/tmp/pids

# 设置工作目录
WORKDIR /ccw-app

# 将 Gemfile 和 Gemfile.lock 拷贝到容器对应的位置
COPY Gemfile /ccw-app/Gemfile
COPY Gemfile.lock /ccw-app/Gemfile.lock

# 设置容器内环境变量
ENV RAILS_ENV demo
ENV RAILS_SERVE_STATIC_FILES true
ENV RAILS_LOG_TO_STDOUT true
ENV POSTGRES_USER dev
ENV POSTGRES_PASSWORD 12345678

RUN gem install bundler:2.0.2

# 执行bundle install
RUN bundle install
#--without development test

# 将项目拷入容器内
COPY . /ccw-app
# 暴露 3000端口
EXPOSE 3000
