FROM node:alpine

WORKDIR /usr/src/app

COPY package*.json ./

RUN npm ci

COPY . .

RUN npm run format-fix

EXPOSE 5003 50053 4003

CMD ["npm", "run", "start:dev"]
