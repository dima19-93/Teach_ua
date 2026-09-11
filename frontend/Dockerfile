FROM node:16-alpine AS build
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .

ENV DISABLE_ESLINT_PLUGIN=true
ENV EXTEND_ESLINT=true
ENV CI=false
ENV NODE_OPTIONS=--openssl-legacy-provider
ENV ESCAPE_ESLINT_ERRORS=true

RUN echo 'export const ROOT_SERVER = "";' > src/config/ApplicationConfig.js && \
    echo 'export const ROOT_URI = "";' >> src/config/ApplicationConfig.js && \
    echo 'export const BASE_URL = `${ROOT_SERVER}/dev`;' >> src/config/ApplicationConfig.js

RUN npm run build



FROM nginx:alpine
COPY nginx.conf /etc/nginx/conf.d/default.conf
COPY --from=build /app/build /usr/share/nginx/html

EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]

