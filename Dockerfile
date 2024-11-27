FROM node:18-alpine
COPY package.json .
COPY /etc/ssl/certs/pse.pem /etc/ssl/certs/pse.pem
ENV NODE_EXTRA_CA_CERTS /etc/ssl/certs/pse.pem
ENV REQUESTS_CA_BUNDLE /etc/ssl/certs/pse.pem
ENV CA_FILE /etc/ssl/certs/pse.pem
RUN update-ca-certificates
RUN npm config set cafile $CA_FILE
RUN npm config set strict-ssl false
RUN npm install -v
