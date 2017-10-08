FROM node

LABEL Author Alessio Occhipinti <info@godev.space>

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

## Java 7
# RUN apt-get update -qqy && \
#   apt-get install -y openjdk-7-jre && \
#   rm -rf /var/lib/apt/lists/*

# ENV JAVA_HOME /usr/lib/jvm/java-7-openjdk-amd64

## Java 8
RUN apt-get update -qqy && \
  apt-get install -qqy software-properties-common python-software-properties && \
  echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | debconf-set-selections && \
  add-apt-repository -y ppa:webupd8team/java && \
  apt-get update && \
  apt-get install -y oracle-java8-installer && \
  rm -rf /var/lib/apt/lists/* && \
  rm -rf /var/cache/oracle-jdk8-installer

ENV JAVA_HOME /usr/lib/jvm/java-8-oracle
