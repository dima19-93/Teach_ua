FROM node:16-alpine
WORKDIR /app

COPY package*.json ./
RUN npm install
RUN npm install http-proxy-middleware@2.1.3

COPY . .


ENV DISABLE_ESLINT_PLUGIN=true
ENV CI=false


RUN sed -i 's/\bROOT_SERVER\b/""/g' src/config/ApplicationConfig.js


EXPOSE 3000

RUN find src/ -type f -name "*.js" -o -name "*.jsx" | xargs sed -i 's|src="dev/static/|src="/dev/static/|g'
CMD ["npm", "start"]

