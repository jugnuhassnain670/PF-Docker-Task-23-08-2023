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