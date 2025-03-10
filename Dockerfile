FROM node:18 AS builder
WORKDIR /app
COPY dockershield/package.json dockershield/package-lock.json ./
RUN npm install
COPY dockershield ./
RUN npm run build

FROM nginx:latest
COPY --from=builder /app/build /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
