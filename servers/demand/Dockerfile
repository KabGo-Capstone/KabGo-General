FROM node:alpine

WORKDIR /usr/src/app

COPY package*.json ./

RUN npm ci

COPY . .

RUN npm run format-fix

EXPOSE 5001 50051

CMD ["npm", "run", "start:dev"]
