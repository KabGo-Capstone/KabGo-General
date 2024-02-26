FROM node:alpine

WORKDIR /usr/src/app

COPY package*.json ./

RUN npm ci

COPY . .

RUN npm run format-fix

EXPOSE 5002 50052

CMD ["npm", "run", "start:dev"]
