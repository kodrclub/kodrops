#
# Please use buildkit for best results:
# $ DOCKER_BUILDKIT=1 docker build . [--target=???]
#
FROM node:14.5.0-alpine as base
ENV NODE_ENV=production
WORKDIR /usr/src/app
COPY package*.json ./
RUN npm install --only=prod
COPY . .

FROM base as dev
EXPOSE 3000
ENV NODE_ENV=development
RUN apk add --no-cache tini && \
    npm install --only=dev
ENTRYPOINT ["tini", "--"]
CMD ["npm", "start"]

FROM base as build
RUN npm run build



FROM nginx:1.19.0-alpine as prod
EXPOSE 80
COPY --from=build /usr/src/app/build /usr/share/nginx/html

