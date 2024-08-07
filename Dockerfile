# Stage 1
FROM node:22-alpine AS build

WORKDIR /usr/src/app
COPY package.json ./
COPY package-lock.json ./
RUN npm install
COPY . .
RUN npm run build

# Stage 2
FROM node:20-alpine

WORKDIR /usr/src/app
ENV NODE_ENV=production
# COPY --from=build /usr/src/app/.env .
COPY --from=build /usr/src/app/package.json ./
COPY --from=build /usr/src/app/package-lock.json ./
RUN npm install --only=prod
COPY --from=build /usr/src/app/dist ./dist
EXPOSE 4000

CMD ["npm", "run", "start:prod"]