FROM ubuntu:latest
#Install packages in ubuntu VM in container 
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get install -y \
    software-properties-common \
    nginx \
    composer \
    nano \
    curl  
# Install php packages
RUN apt install -y php8.1-fpm php8.1-bcmath php8.1-cli php8.1-common php8.1-curl php8.1-dev php8.1-fpm php8.1-gd php8.1-imagick php8.1-mbstring php8.1-memcache php8.1-mongodb php8.1-mysql php8.1-redis
RUN apt install -y php8.1-opcache php8.1-pgsql php8.1-pspell php8.1-readline php8.1-snmp php8.1-sqlite3 php8.1-ssh2 php8.1-xml php8.1-xmlrpc php8.1-xsl php8.1-zip
#install composer 
RUN curl -sS https://getcomposer.org/installer | php 
RUN mv composer.phar /usr/local/bin/composer
RUN composer global require laravel/installer
# install npm and python
RUN apt-get install -y nodejs npm
RUN apt install -y python3 pip
# make working directory
WORKDIR /app
# copy all projects in the working directory
COPY . .
RUN chmod 777 -R /app
# copy nginx configuration 
COPY ./nginx/default /etc/nginx/sites-enabled/default
# install packages of projects.
# Laravel
WORKDIR /app/Laravel
RUN composer install
# Vue project
WORKDIR /app/vue-project/project-name
RUN npm install && npm run build
# Node project
WORKDIR /app/Node
RUN npm install 
#Python
WORKDIR /app/Python
RUN pip3 install -r requirements.txt 
# Expose port
EXPOSE 80
CMD ["sh", "-c", "service php8.1-fpm start & node /app/Node/index.js & python3 /app/Python/app.py & nginx -g 'daemon off;'"]
