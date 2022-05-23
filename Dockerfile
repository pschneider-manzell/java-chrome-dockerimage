FROM maven:3.8.5-jdk-11

ARG NVM_VERSION=v0.39.1
ARG NODE_VERSION=v8.12.0
ARG NVM_DIR=/usr/local/nvm

RUN apt-get update \
   && apt-get install -y gettext-base \
   && echo 'deb http://dl.google.com/linux/chrome/deb/ stable main' > /etc/apt/sources.list.d/chrome.list \
   && wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - \
   && set -x  \
   && apt-get update  \
   && apt-get install -y xvfb google-chrome-stable \
   && wget -q -O /usr/bin/xvfb-chrome https://bitbucket.org/atlassian/docker-node-chrome-firefox/raw/ff180e2f16ea8639d4ca4a3abb0017ee23c2836c/scripts/xvfb-chrome \
   && ln -sf /usr/bin/xvfb-chrome /usr/bin/google-chrome \
   && chmod 755 /usr/bin/google-chrome \
   && mkdir $NVM_DIR \
   && curl -o- https://raw.githubusercontent.com/creationix/nvm/$NVM_VERSION/install.sh | bash
ENV NODE_PATH=/usr/local/nvm/vv8.12.0/lib/node_modules
ENV PATH=/usr/local/nvm/versions/node/vv8.12.0/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
RUN echo "source $NVM_DIR/nvm.sh &&     nvm install $NODE_VERSION &&     nvm alias default $NODE_VERSION &&     nvm use default" | bash
