FROM node:12.13-alpine AS development

WORKDIR /usr/src/app
COPY package.json ./
# COPY yarnß ./
#RUN yarn --only=development
RUN yarn

COPY . .

FROM node:12.13-alpine AS production

ARG NODE_ENV=production
ENV NODE_ENV=${NODE_ENV}

WORKDIR /usr/src/app

COPY package*.json ./
COPY yarn.* ./

#RUN yarn --production
RUN yarn

RUN yarn build

COPY --from=development . ./dist

RUN ls -l

CMD ["node", "dist/main"]

#CMD ["pm2-runtime", "dist/main"]

