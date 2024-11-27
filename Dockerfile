FROM node:18-alpine
COPY package.json .
COPY /etc/ssl/certs/pse.pem /etc/ssl/certs/pse.pem
ENV NODE_EXTRA_CA_CERTS /etc/ssl/certs/pse.pem
ENV REQUESTS_CA_BUNDLE /etc/ssl/certs/pse.pem"
RUN npm install -v
