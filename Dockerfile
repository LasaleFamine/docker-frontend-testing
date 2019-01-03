FROM ubuntu

LABEL Author Alessio Occhipinti <info@godev.space>

## Utils
RUN apt-get update && \
    apt-get install -qqy curl && \
    apt-get install -qqy wget && \
    apt-get install -qqy git

## Node and yarn
RUN curl -sL https://deb.nodesource.com/setup_10.x | bash && \
    apt-get update && \
    apt-get install -qqy nodejs

RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add && \
    echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && \
    apt-get update && apt-get install -qqy yarn

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
RUN mv /usr/bin/google-chrome /usr/bin/google-chrome-orig \
    && echo '#!/bin/bash' > /usr/bin/google-chrome \
    && echo '/usr/bin/google-chrome-orig --no-sandbox --disable-setuid-sandbox --allow-sandbox-debugging "$@"' >> /usr/bin/google-chrome  \
    && chmod +x /usr/bin/google-chrome

RUN apt-get update && \
    apt-get install -qqy \
      firefox

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
