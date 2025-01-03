FROM	ubuntu

SHELL	["/bin/bash", "-o", "pipefail", "-c"]

# Install packages
ARG	DEBIAN_FRONTEND=noninteractive
RUN	apt-get update \
&&	apt-get -y upgrade \
&&	apt-get -y --no-install-recommends install npm wget \
&&	rm -rf /var/lib/apt/lists/* \
&&	npm install markdownlint-cli2 --global

RUN	wget -O /bin/sedfile https://raw.githubusercontent.com/casperklein/bash-pack/master/sedfile \
&&	chmod 700 /bin/sedfile \
# disable MD013 - Line length (https://github.com/DavidAnson/markdownlint/blob/main/doc/md013.md)
&&	sedfile -i '/md013/d' /usr/local/lib/node_modules/markdownlint-cli2/node_modules/markdownlint/lib/rules.mjs \
&&	rm /bin/sedfile

ARG	VERSION="unknown"

LABEL	org.opencontainers.image.version="$VERSION"

CMD	["markdownlint-cli2"]
