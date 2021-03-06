FROM node:12.18.3 As development

WORKDIR /usr/src/app
COPY package*.json ./

#RUN npm install pm2 -g

#RUN npm install --only=development
RUN yarn --only=development

COPY . .

CMD ["npm", "run", "start"]


FROM node:12.18.3 As production

ARG NODE_ENV=production
ENV NODE_ENV=${NODE_ENV}

WORKDIR /usr/src/app

#COPY package*.json ./
COPY yarn.* ./

#RUN npm install  --only=production
RUN yarn  --only=production

COPY . .

COPY --from=development /usr/src/app/dist ./dist

RUN yarn build

CMD ["node", "dist/main"]

CMD ["pm2-runtime", "dist/main"]

