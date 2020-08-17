FROM node:14.5.0-stretch

WORKDIR /app

COPY package.json .
RUN npm install --only=prod
COPY . .

CMD ["npm", "start"]