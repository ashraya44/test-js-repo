FROM node:18-alpine
# Copy application files
#COPY . .
# RUN npm run build --if-present

# CMD ["npm", "start"]

ENV HTTP_PROXY http://172.18.0.3:12345
ENV HTTPS_PROXY http://172.18.0.3:12345
# Copy your custom CA certificate
ADD pse.pem /etc/ssl/certs/pse.pem
RUN ls /etc/ssl/certs/
RUN cp /etc/ssl/certs/pse.pem /etc/ssl/certs/ca-certificates.crt
RUN mkdir /usr/local/share/ca-certificates/
RUN cp /etc/ssl/certs/ca-certificates.crt /usr/local/share/ca-certificates/
RUN cat /etc/ssl/certs/pse.pem
RUN cat /etc/ssl/certs/ca-certificates.crt
# Set environment variables for Node.js and npm to trust the custom CA
ENV NODE_EXTRA_CA_CERTS=/etc/ssl/certs/ca-certificates.crt
ENV REQUESTS_CA_BUNDLE=/etc/ssl/certs/ca-certificates.crt
ENV CA_FILE=/etc/ssl/certs/ca-certificates.crt

#RUN wget google.com

RUN apk update

RUN apk --no-cache add ca-certificates
RUN update-ca-certificate
# Manually update the CA certificates without 'update-ca-certificates'
RUN cat /etc/ssl/certs/pse.pem >> /etc/ssl/certs/ca-certificates.crt
RUN cat /etc/resolv.conf

# Configure npm to use the custom CA and ignore strict SSL checks if needed
RUN npm config set cafile $CA_FILE
RUN npm config set strict-ssl false
RUN npm config list
COPY package.json .
RUN npm install
# Install dependencies
RUN npm install -v
