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