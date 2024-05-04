# Stage 1: Install dependencies and build the application
FROM node:20-alpine3.18 AS deps

# Install dependencies
RUN apk add --update --no-cache git openssh libc6-compat build-base python3

WORKDIR /src/app
COPY package.json yarn.lock ./
RUN yarn install --frozen-lockfile

# Rebuild the source code only when needed
FROM node:20-alpine3.18 AS builder
WORKDIR /src/app
COPY . .
COPY --from=deps /src/app/node_modules ./node_modules

RUN yarn build

# Production image, copy all the files and run
FROM node:20-alpine3.18 AS runner
WORKDIR /src/app

ENV GENERATE_SOURCEMAP false

COPY --from=builder /src/app/.next ./.next
COPY --from=builder /src/app/public ./public
COPY --from=builder /src/app/.env .env
COPY --from=builder /src/app/next.config.mjs next.config.mjs
COPY --from=builder /src/app/package.json package.json
COPY --from=builder /src/app/node_modules ./node_modules

EXPOSE 3000

CMD ["yarn","start"]