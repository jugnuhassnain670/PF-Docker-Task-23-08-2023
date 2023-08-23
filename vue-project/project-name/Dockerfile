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

