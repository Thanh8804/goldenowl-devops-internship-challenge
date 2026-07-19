FROM node:24-alpine AS deps

WORKDIR /app

COPY src/package*.json ./

RUN npm ci --omit=dev

FROM node:24-alpine AS runner

RUN rm -rf /usr/local/lib/node_modules /opt/yarn* \
    /usr/local/bin/npm /usr/local/bin/npx /usr/local/bin/corepack \
    /usr/local/bin/yarn /usr/local/bin/yarnpkg

WORKDIR /app

COPY --from=deps --chown=node:node /app/node_modules ./node_modules
COPY --chown=node:node src/package*.json ./
COPY --chown=node:node src/index.js ./
COPY --chown=node:node src/routes/ ./routes/
COPY --chown=node:node src/server/ ./server/

USER node

EXPOSE 3000

CMD ["node", "index.js"]
