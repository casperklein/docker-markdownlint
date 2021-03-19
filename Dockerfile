FROM	ubuntu

SHELL	["/bin/bash", "-o", "pipefail", "-c"]

# Install packages
ENV	DEBIAN_FRONTEND=noninteractive
RUN	apt-get update \
&&	apt-get -y upgrade \
&&	apt-get -y --no-install-recommends install npm \
&&	rm -rf /var/lib/apt/lists/* \
&&	npm install markdownlint-cli2 --global \
# disable MD013
&&	sed -i '/md013/d' /usr/local/lib/node_modules/markdownlint-cli2/node_modules/markdownlint/lib/rules.js

ARG	VERSION
ENV	Version=$VERSION

CMD	["markdownlint-cli2"]
