FROM node:10-alpine as builder
MAINTAINER wangying@dragonest.com
RUN apk add --no-cache git python make openssl tar gcc
RUN mkdir /api && cd /api && \
  git clone --depth=1  https://github.com/smartwang/yapi.git vendors 
RUN cd /api/vendors &&  npm install
RUN cp /api/vendors/config_example.json /api/config.json && \
  ./node_modules/ykit/bin/ykit pack -m



FROM node:10-alpine
MAINTAINER wangying@dragonest.com
ENV TZ="Asia/Shanghai"
COPY --from=builder /api/vendors /api/vendors
ENTRYPOINT ["node"]
