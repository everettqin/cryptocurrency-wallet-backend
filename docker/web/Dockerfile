# Base image nginx 基础镜像
FROM nginx:1.15.5

# 安装依赖
RUN apt-get update -qq && apt-get -y install apache2-utils

# 定义好Nginx应该在哪里查找文件
ENV RAILS_ROOT /ccw-app

# 设定镜像内工作目录
WORKDIR $RAILS_ROOT

# 创建存放日志文件夹
RUN mkdir log

# 复制静态文件到镜像内
COPY public public/

# 复制证书文件到镜像内
#COPY cert /etc/nginx/cert

# 复制 Nginx 配置模版
COPY docker/web/nginx.conf /tmp/docker.nginx
# 用Nginx配置模板中的变量引用替换环境中的真实值
# 把最终配置放在指定位置
RUN envsubst '$RAILS_ROOT' < /tmp/docker.nginx > /etc/nginx/conf.d/default.conf

EXPOSE 80
# Use the "exec" form of CMD so Nginx shuts down gracefully on SIGTERM (i.e. `docker stop`)
CMD [ "nginx", "-g", "daemon off;" ]