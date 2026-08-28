FROM node:18-alpine
WORKDIR /app

COPY package*.json ./
RUN npm install
RUN npm install http-proxy-middleware@2.0.10

COPY . .


ENV DISABLE_ESLINT_PLUGIN=true
ENV CI=false
ENV REACT_APP_ROOT_SERVER=http://192.168.33.11

ARG GOOGLE_MAPS_API_KEY
ENV REACT_APP_GOOGLE_MAPS_API_KEY=$GOOGLE_MAPS_API_KEY

RUN sed -i 's/\bROOT_SERVER\b/""/g' src/config/ApplicationConfig.js


EXPOSE 3000

RUN find src/ -type f -name "*.js" -o -name "*.jsx" | xargs sed -i 's|src="dev/static/|src="/dev/static/|g'
CMD ["npm", "start"]

