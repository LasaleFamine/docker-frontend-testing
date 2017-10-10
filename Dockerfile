FROM ubuntu

LABEL Author Alessio Occhipinti <info@godev.space>

## Node and yarn
RUN apt-get update && apt-get install -qqy curl && \
    apt-get install -qqy build-essential libssl-dev && \
    curl -sL https://raw.githubusercontent.com/creationix/nvm/v0.31.0/install.sh -o install_nvm.sh && \
    bash install_nvm.sh && \
    . ~/.bashrc && \
    nvm use 8

RUN curl -o- -L https://yarnpkg.com/install.sh | bash

## Add Xvfb
RUN apt-get update && apt-get -y install \
      gtk2-engines-pixbuf \
      libxtst6 \
      xfonts-100dpi \
      xfonts-75dpi \
      xfonts-base \
      xfonts-cyrillic \
      xfonts-scalable \
      xvfb

## Chrome
RUN wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add -
RUN echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list
RUN apt-get update && apt-get install -y \
	    google-chrome-stable
RUN echo "alias chrome=google-chrome" >> ~/.bashrc && \
    echo "alias chrome=google-chrome-stable" >> ~/.bashrc

## Firefox
ARG FIREFOX_VERSION=55.0.3
RUN apt-get update -qqy \
  && rm -rf /var/lib/apt/lists/* /var/cache/apt/* \
  && wget --no-verbose -O /tmp/firefox.tar.bz2 https://download-installer.cdn.mozilla.net/pub/firefox/releases/$FIREFOX_VERSION/linux-x86_64/en-US/firefox-$FIREFOX_VERSION.tar.bz2 \
  && rm -rf /opt/firefox \
  && tar -C /opt -xjf /tmp/firefox.tar.bz2 \
  && rm /tmp/firefox.tar.bz2 \
  && mv /opt/firefox /opt/firefox-$FIREFOX_VERSION \
  && ln -fs /opt/firefox-$FIREFOX_VERSION/firefox /usr/bin/firefox

## Java 8
RUN apt-get update -qqy && \
  apt-get install -y openjdk-8-jre && \
  rm -rf /var/lib/apt/lists/*
ENV JAVA_HOME /usr/lib/jvm/java-8-openjdk-amd64

## Java 8 (debian)
# RUN echo "deb http://http.debian.net/debian jessie-backports main" | tee --append /etc/apt/sources.list.d/jessie-backports.list > /dev/null && \
#     apt-get update && \
#     apt-get install -qqy -t jessie-backports openjdk-8-jdk && \
#     update-java-alternatives -s java-1.8.0-openjdk-amd64
