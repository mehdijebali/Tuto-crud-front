FROM node:12-alpine3.15

WORKDIR /app

COPY . .

RUN npm install
RUN npm run build

CMD ["node","dist/src/main.ts"]