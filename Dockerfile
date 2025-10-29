FROM node:20-alpine as builder
WORKDIR /app
COPY package.json ./
RUN npm install --legacy-peer-deps
COPY . .
RUN NODE_OPTIONS=--openssl-legacy-provider npm run build -- --output-path=./dist/browser --configuration=production

FROM nginx:stable-alpine
COPY --from=builder /app/dist/browser /usr/share/nginx/html
COPY nginx.conf /etc/nginx/conf.d/app.conf
