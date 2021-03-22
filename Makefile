DOCKER_IMAGE_NAME=knowledge-share-img:latest

.PHONY: help
help: ## make コマンド一覧
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}' ${MAKEFILE_LIST}

.PHONY: img-build
img-build: ## 開発環境の docker build
	docker build --force-rm -f Dockerfile -t ${DOCKER_IMAGE_NAME} .

.PHONY: img-rm
img-rm: ## 開発環境の docker build
	docker rmi -f ${DOCKER_IMAGE_NAME}

.PHONY: lint-md
lint-md: ## markdownlint による静的解析
# TODO

.PHONY: lint-txt
lint-txt: ## textlint による静的解析
# TODO

.PHONY: pandoc
pandoc: ## pandoc による書き出し
	docker run --rm -it -u  `id -u`:`id -g` -v "`pwd`:/knowledge-share" knowledge-share-img \
	find . -name "*.md" -not -name "README.md" | \
	pandoc -c ./stylesheet.css -f markdown_strict -t lualatex -o ./knowledge-share.pdf

# TODO
# docker から pandoc を実行する
# pdf 出力に対応する
# 日本語出力に対応する
# pandoc のオプションを yml に移す