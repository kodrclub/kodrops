FROM node:14.5.0-alpine

EXPOSE 3000

RUN apk add --no-cache tini

WORKDIR /usr/src/app

COPY package*.json ./

RUN npm install --only=prod && npm cache clean --force

COPY . .

ENTRYPOINT ["tini", "--"]

CMD ["npm", "start"]
