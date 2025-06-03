FROM node:18

WORKDIR /admin

ENV TZ="UTC"

# Устанавливаем зависимости без NODE_ENV=production
COPY package.json ./
COPY yarn.lock ./
RUN yarn install --frozen-lockfile

# Только после установки зависимостей указываем production
ENV NODE_ENV="production"

COPY . .

RUN npm i -g typescript
RUN yarn build
RUN npx prisma generate
RUN rm -rf src

ENV ADMIN_JS_SKIP_BUNDLE="true"

EXPOSE 3000
CMD yarn start
