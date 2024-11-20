FROM node:18-alpine
RUN --network=host
COPY package.json .
RUN npm install
