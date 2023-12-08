FROM maven:3.9.5-amazoncorretto-17-debian

ENV NVM_VERSION=v0.39.7
ENV NODE_VERSION=v18.19.0
ENV NVM_DIR=/usr/local/nvm

RUN apt-get update \
&& apt-get install -y gettext-base \
&& apt-get install -y wget \
&& apt-get install -y gnupg \
&& apt-get install -y unzip \
&& apt-get install -y curl \
&& echo 'deb http://dl.google.com/linux/chrome/deb/ stable main' > /etc/apt/sources.list.d/chrome.list \
&& wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - \
&& set -x \
&& apt-get update \
&& apt-get install -y xvfb google-chrome-stable \
&& wget https://chromedriver.storage.googleapis.com/2.22/chromedriver_linux64.zip \
&& unzip chromedriver_linux64.zip \
&& cp ./chromedriver /usr/bin/xvfb-chrome \
&& chmod ugo+rx /usr/bin/xvfb-chrome \
&& ln -sf /usr/bin/xvfb-chrome /usr/bin/google-chrome \
&& chmod 755 /usr/bin/google-chrome \
&& mkdir $NVM_DIR \
&& curl -o- https://raw.githubusercontent.com/creationix/nvm/$NVM_VERSION/install.sh | bash \
&& rm /bin/sh && ln -s /bin/bash /bin/sh
ENV NODE_PATH=$NVM_DIR/$NODE_VERSION/lib/node_modules
ENV PATH=$NVM_DIR/versions/node/$NODE_VERSION/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
RUN echo "source ~/.bashrc && nvm install $NODE_VERSION && nvm alias default $NODE_VERSION && nvm use default" | bash
