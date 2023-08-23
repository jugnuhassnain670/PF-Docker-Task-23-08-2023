-----------------------------------Documentation-------------------------------
Task 01:  Create a Laravel Project  locally and test its working on NGINX web server
          - Create a ubuntu:22.04 container  
               CMD: docker run -it ubuntu:22.04
          - Enter into ubuntu container 
               CMD: docker exec -it {container id} /bin/bash
          - Updates Ubuntu packages & install some more packgages.
               CMD: apt-get update && apt-get install -y \
                    software-properties-common \
                    nginx \
                    composer \
                    curl  \
                    nano  
          - Install php and composer in your VM
               CMD: 
                  RUN 1) apt install -y php8.1-fpm php8.1-bcmath php8.1-cli php8.1-common php8.1-curl php8.1-dev php8.1-fpm php8.1-gd php8.1-imagick php8.1-mbstring php8.1-memcache php8.1-mongodb php8.1-mysql php8.1-redis
                  RUN 2) apt install -y php8.1-opcache php8.1-pgsql php8.1-pspell php8.1-readline php8.1-snmp php8.1-sqlite3 php8.1-ssh2 php8.1-xml php8.1-xmlrpc php8.1-xsl php8.1-zip
                  RUN 3) curl -sS https://getcomposer.org/installer | php 
                  RUN 4) mv composer.phar /usr/local/bin/composer
                  RUN 5) composer global require laravel/installer
          - Create a Laravel Project 
               CMD: composer create-project laravel/laravel jugnu-laravel-app --ignore-platform-req=ext-curl
          - Change the permissions of project folder
               CMD: chmod 777 -R {folder path}
          - Change the NGINX configurations 
                  server {
                        listen 80;
                        server_name your-domain.com;
                        root /app/public;  # Adjust this to the appropriate path of your Laravel public directory

                        index index.php index.html index.htm;

                        location / {
                           try_files $uri $uri/ /index.php?$query_string;
                        }

                        location ~ \.php$ {
                           include fastcgi_params;
                           fastcgi_pass unix:/var/run/php/php8.1-fpm.sock;  # Adjust the PHP-FPM socket path if needed
                           fastcgi_index index.php;
                           fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;
                        }

                        location ~ /\.ht {
                           deny all;
                        }
                  }

----------------Your Laravel project working fine locally on ubuntu VM with NGINX-------------------

If you want to run this project with Dockerfile

Steps: 
   create a file with name Dockerfile in project folder 

            FROM ubuntu:22.04
            ENV DEBIAN_FRONTEND=noninteractive
            RUN apt-get update && apt-get install -y \
               software-properties-common \
               nginx \
               composer \
               curl  \
               nano
            RUN apt install -y php8.1-fpm php8.1-bcmath php8.1-cli php8.1-common php8.1-curl php8.1-dev php8.1-fpm php8.1-gd php8.1-imagick php8.1-mbstring php8.1-memcache php8.1-mongodb php8.1-mysql php8.1-redis
            RUN apt install -y php8.1-opcache php8.1-pgsql php8.1-pspell php8.1-readline php8.1-snmp php8.1-sqlite3 php8.1-ssh2 php8.1-xml php8.1-xmlrpc php8.1-xsl php8.1-zip
            WORKDIR /app
            COPY . .
            RUN curl -sS https://getcomposer.org/installer | php 
            RUN mv composer.phar /usr/local/bin/composer
            RUN composer global require laravel/installer
            WORKDIR /app
            RUN composer install
            RUN chmod -R 777 /var
            COPY ./nginx/default /etc/nginx/sites-enabled/default
            EXPOSE 80
            CMD service php8.1-fpm start && nginx -g "daemon off;"


   Important Note:--------------
            create a folder nginx in project folder and make a file name with default 
            & paste nginx configuration file and save it...

   Command for build docker file.
            CMD: docker run -t {file name that you want} .
   Command for run container from image
            CMD: docker run -d --name {name of container} -p 80:80 {image name}


               --------------------------Task 01 complete--------------------------------

Task 02:  Create a Node Project locally and test its working on NGINX web server
          - Create a ubuntu:22.04 container  
               CMD: docker run -it ubuntu:22.04
          - Enter into ubuntu container 
               CMD: docker exec -it {container id} /bin/bash
          - Updates Ubuntu packages & install some more packgages.
               CMD: apt-get update && apt-get install -y \
                    software-properties-common \
                    nginx \
                    composer \
                    curl  \
                    nano  
          - Install node and npm in your VM
               CMD: 
                  RUN 1) apt install -y nodejs npm
                  
          - Create a Node Project 
               CMD: npm init 
               create a index.js file and write a code for your project. i have already share sample in Node project folder.
          - Run node project
               CMD: node index.js
          - Change the NGINX configurations 
                  server {
                        listen 80 default_server;
                        listen [::]:80 default_server;
                        root /var/www/html;
                        index index.html index.htm index.nginx-debian.html;
                        server_name _;
                        location / {
                                 proxy_pass http://127.0.0.1:8081/;
                                 proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
                                 proxy_set_header X-Forwarded-Proto $scheme;
                                 proxy_set_header X-Forwarded-Host $host;
                                 proxy_set_header X-Forwarded-Prefix /;
                                 try_files $uri $uri/ =404;
                        }
                  }

----------------Your Node project working fine locally on ubuntu VM with NGINX-------------------

If you want to run this project with Dockerfile

Steps: 
   create a file with name Dockerfile in project folder 

            FROM ubuntu:22.04
            RUN apt-get update && apt-get install -y \
               software-properties-common \
               nginx \
               nodejs \
               npm \
               curl \
               nano \
               curl  
            WORKDIR /app
            COPY package*.json ./
            RUN npm install
            COPY ./nginx/default /etc/nginx/sites-enabled/default
            COPY . .
            EXPOSE 80
            CMD ["sh", "-c", "node index.js & nginx -g 'daemon off;'"]


   Important Note:--------------
            create a folder nginx in project folder and make a file name with default 
            & paste nginx configuration file and save it...

   Command for build docker file.
            CMD: docker run -t {file name that you want} .
   Command for run container from image
            CMD: docker run -d --name {name of container} -p 80:80 {image name}


               --------------------------Task 02 complete--------------------------------


Task 03:  Create a Vue Project locally and test its working on NGINX web server
          - Create a ubuntu:22.04 container  
               CMD: docker run -it ubuntu:22.04
          - Enter into ubuntu container 
               CMD: docker exec -it {container id} /bin/bash
          - Updates Ubuntu packages & install some more packgages.
               CMD: apt-get update && apt-get install -y \
                     software-properties-common \
                     nginx \
                     npm \
                     nodejs \
                     unzip \
                     curl            
          - Install vue/cli 
               CMD: npm install -g @vue/cli
          - Create a Vue Project 
               CMD: vue create {project-name}
          - Run vue project
               CMD: npm run serve
          - Change the NGINX configurations 
                  server {
                        listen 80 default_server;
                        listen [::]:80 default_server;
                        root /var/www/html;
                        index index.html index.htm index.nginx-debian.html;
                        server_name _;
                        location / {
                                 proxy_pass http://127.0.0.1:8080/;
                                 proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
                                 proxy_set_header X-Forwarded-Proto $scheme;
                                 proxy_set_header X-Forwarded-Host $host;
                                 proxy_set_header X-Forwarded-Prefix /;
                                 try_files $uri $uri/ =404;
                        }
                  }

----------------Your Vue project working fine locally on ubuntu VM with NGINX-------------------

If you want to run this project with Dockerfile

Steps: 
   create a file with name Dockerfile in project folder 

            FROM ubuntu:22.04
            ENV DEBIAN_FRONTEND=noninteractive
            RUN apt-get update && apt-get install -y \
               software-properties-common \
               nginx \
               npm \
               nodejs \
               unzip \
               curl  
            WORKDIR /app
            COPY package*.json ./
            RUN npm install
            COPY ./nginx/default /etc/nginx/sites-enabled/default
            COPY . .
            EXPOSE 8080
            CMD ["sh", "-c", "npm run serve & nginx -g 'daemon off;'"]

   Important Note:--------------
            create a folder nginx in project folder and make a file name with default 
            & paste nginx configuration file and save it...

   Command for build docker file.
            CMD: docker run -t {file name that you want} .
   Command for run container from image
            CMD: docker run -d --name {name of container} -p 80:80 {image name}


               --------------------------Task 03 complete--------------------------------

Task 04:  Create a Python Project locally and test its working on NGINX web server
          - Create a ubuntu:22.04 container  
               CMD: docker run -it ubuntu:22.04
          - Enter into ubuntu container 
               CMD: docker exec -it {container id} /bin/bash
          - Updates Ubuntu packages & install some more packgages.
               CMD: apt-get update && apt-get install -y \
                     software-properties-common \
                     nginx \
                     python3 \
                     pip \
                     curl \
                     nano \
                     curl         
          - Create a python Project 
               create app.py file and write a code i have already share code in file..
          - Run python project
               CMD: python3 app.py
          - Change the NGINX configurations 
                  server {
                        listen 80 default_server;
                        listen [::]:80 default_server;
                        root /var/www/html;
                        index index.html index.htm index.nginx-debian.html;
                        server_name _;
                        location / {
                                 proxy_pass http://127.0.0.1:5000/;
                                 proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
                                 proxy_set_header X-Forwarded-Proto $scheme;
                                 proxy_set_header X-Forwarded-Host $host;
                                 proxy_set_header X-Forwarded-Prefix /;
                                 try_files $uri $uri/ =404;
                        }
                  }

----------------Your Python project working fine locally on ubuntu VM with NGINX-------------------

If you want to run this project with Dockerfile

Steps: 
   create a file with name Dockerfile in project folder 

            FROM ubuntu:22.04
            RUN apt-get update && apt-get install -y \
               software-properties-common \
               nginx \
               python3 \
               pip \
               curl \
               nano \
               curl  
            WORKDIR /app
            COPY ./nginx/default /etc/nginx/sites-available/default
            COPY requirements.txt requirements.txt
            RUN pip3 install -r requirements.txt
            COPY . .
            EXPOSE 80
            CMD ["sh", "-c", "python app.py & nginx -g 'daemon off;'"]

   Important Note:--------------
            create a folder nginx in project folder and make a file name with default 
            & paste nginx configuration file and save it...

   Command for build docker file.
            CMD: docker run -t {file name that you want} .
   Command for run container from image
            CMD: docker run -d --name {name of container} -p 80:80 {image name}


               --------------------------Task 04 complete--------------------------------



Final task:
   create a single docker file that runs all four projects in a single container 

   Dockerfile:
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
         