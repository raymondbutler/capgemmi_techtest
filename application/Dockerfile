FROM node:latest
LABEL MAINTAINER="Raymond Butler <me@raymondbutler.co.uk>"
RUN apt-get -y update && apt-get install -y apt-utils sqlite3
# Debug tools not for production
RUN apt-get -y update && apt-get install -y net-tools telnet mc nano vim wget
RUN apt-get clean && rm -rf /var/lib/apt/lists/*
WORKDIR /app
COPY notejam/package*.json .
RUN npm install
# COPY webserver.js webserver.js
COPY notejam/ .
RUN node db.js
EXPOSE 80
