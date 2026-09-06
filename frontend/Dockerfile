FROM node:18-alpine AS build
WORKDIR /app
COPY package*.json ./


RUN npm install

COPY . .


ENV DISABLE_ESLINT_PLUGIN=true
ENV EXTEND_ESLINT=true
ENV CI=false
ENV NODE_OPTIONS=--openssl-legacy-provider
ENV ESCAPE_ESLINT_ERRORS=true
ENV REACT_APP_ROOT_SERVER=http://teachua-modular-alb-48036850.eu-central-1.elb.amazonaws.com


RUN cat << 'EOF' > src/config/ApplicationConfig.js
export const ROOT_SERVER = "http://teachua-modular-alb-48036850.eu-central-1.elb.amazonaws.com";
export const ROOT_URI = "";
export const BASE_URL = `${ROOT_SERVER}/dev`;
EOF


RUN find src/ -type f -name "*.js" -o -name "*.jsx" | xargs sed -i 's|src="dev/static/|src="/dev/static/|g'


RUN npm run build



FROM nginx:alpine

RUN sed -i 's/listen       80;/listen       3000;/g' /etc/nginx/conf.d/default.conf


COPY --from=build /app/build /usr/share/nginx/html

EXPOSE 3000
CMD ["nginx", "-g", "daemon off;"]

