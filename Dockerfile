FROM node:22-alpine

WORKDIR /usr/src/app
COPY package.json ./
COPY package-lock.json ./
RUN npm install
COPY . .
RUN npm run build
EXPOSE 4000

CMD ["npm", "run", "start:prod"]