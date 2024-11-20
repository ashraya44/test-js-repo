FROM node:18-alpine
ENV BASE_URL https://pse.invisirisk.com
ENV CA_FILE /etc/ssl/certs/pse.pem
RUN apk add iptables ca-certificates git curl python3 py3-pip openssl
RUN iptables -t nat -N pse-proxy \
    iptables -t nat -A OUTPUT -j pse-proxy \
    PSE_IP=$(getent hosts pse-proxy | awk '{ print $1 }') \
    echo "PSE_IP is ${PSE_IP}" \
    iptables -t nat -A "$PSE_CONTAINER_NAME" -p tcp -m tcp --dport 443 -j DNAT --to-destination "${PSE_IP}:12345" \
RUN curl -s -o "$CA_FILE" https://pse.invisirisk.com/ca \
    -H 'User-Agent: CICD' \
    --insecure
RUN update-ca-certificates
COPY package.json .
RUN npm install
