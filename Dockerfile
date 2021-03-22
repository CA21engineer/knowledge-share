FROM pandoc/crossref:2.12

WORKDIR /knowledge-share

COPY ./ ./

RUN set -ex \
  && apk update \
  && apk add --no-cache nodejs-npm findutils \
  && rm -rf /var/cache/apk/* \
  && npm i -D markdownlint-cli textlint textlint-rule-preset-japanese \
  && npm audit fix

# ベースイメージの ENTRYPOINT を無効化
ENTRYPOINT []