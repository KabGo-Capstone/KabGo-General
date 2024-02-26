FROM node:alpine

WORKDIR /usr/src/app

COPY package*.json ./

RUN npm ci 

COPY . .

EXPOSE 3002

CMD ["npm", "start"]