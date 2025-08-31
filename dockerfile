FROM node:22.14-alpine AS deps

WORKDIR /app

RUN apk add --no-cache python3 make g++ libc-dev linux-headers

COPY package.json package-lock.json* ./

RUN npm install

COPY . .

FROM node:22.14-alpine AS runtime

WORKDIR /app

RUN apk add --no-cache sqlite-libs tini

COPY --from=deps /app/node_modules ./node_modules
COPY --from=deps /app ./ 

RUN addgroup -S app && adduser -S app -G app \
    && chown -R app:app /app

USER app

ENV NODE_ENV=production

EXPOSE 8000

ENTRYPOINT ["/sbin/tini", "--"]
CMD ["npm", "start"]
