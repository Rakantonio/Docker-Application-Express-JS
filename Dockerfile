FROM node:12-alpine3.9

# Default node workdir /app
WORKDIR /app

ENV NODE_ENV=production

# copy the package.json inside the current directory
COPY package.json .

#copy the file inside src to /app/src/
COPY src/ ./src/

RUN npm install --production \
    && npm audit fix --force

CMD ["node", "src/index.js"]

