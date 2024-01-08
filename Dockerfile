FROM --platform=linux/amd64 maven:3.9.5-amazoncorretto-17-debian

ENV NVM_VERSION=v0.39.7
ENV NODE_VERSION=v18.19.0
ENV NVM_DIR=/usr/local/nvm

RUN apt-get update \
   && apt-get install -y gettext-base \
   && apt-get install -y wget \
   && apt-get install -y gnupg \
   && apt-get install -y unzip \
   && apt-get install -y curl \
   && echo 'deb http://dl.google.com/linux/chrome/deb/ stable main' > /etc/apt/sources.list.d/google-chrome.list \
   && wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - \
   && set -x  \
   && apt-get update  \
   && apt-get install -y xvfb google-chrome-stable \
   && mkdir $NVM_DIR \
   && curl -o- https://raw.githubusercontent.com/creationix/nvm/$NVM_VERSION/install.sh | bash
ENV NODE_PATH=$NVM_DIR/$NODE_VERSION/lib/node_modules
ENV PATH=$NVM_DIR/versions/node/$NODE_VERSION/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
RUN echo "source ~/.bashrc && nvm install $NODE_VERSION && nvm alias default $NODE_VERSION && nvm use default" | bash
