FROM node:18-alpine

COPY . .
RUN cp pse.pem /etc/ssl/certs/pse.pem
RUN npm config set cafile "$CA_FILE"
RUN npm config set strict-ssl false

RUN npm install
# RUN npm run build --if-present

# CMD ["npm", "start"]
