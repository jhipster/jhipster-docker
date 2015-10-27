# DOCKER-VERSION 0.7.1
FROM      ubuntu:trusty
MAINTAINER Julien Dubois <julien.dubois@gmail.com>

ENV JAVA_VERSION 8
ENV JAVA_HOME /usr/lib/jvm/java-8-oracle

ENV MAVEN_VERSION 3.3.3
ENV MAVEN_HOME /usr/share/maven
ENV PATH "$PATH:$MAVEN_HOME/bin"

RUN apt-get install -y curl
RUN curl -fsSL http://archive.apache.org/dist/maven/maven-3/$MAVEN_VERSION/binaries/apache-maven-$MAVEN_VERSION-bin.tar.gz | tar xzf - -C /usr/share \
  && mv /usr/share/apache-maven-$MAVEN_VERSION /usr/share/maven \
  && ln -s /usr/share/maven/bin/mvn /usr/bin/mvn

RUN echo 'deb http://ppa.launchpad.net/webupd8team/java/ubuntu trusty main' >> /etc/apt/sources.list && \
    echo 'deb-src http://ppa.launchpad.net/webupd8team/java/ubuntu trusty main' >> /etc/apt/sources.list && \
    apt-key adv --keyserver keyserver.ubuntu.com --recv-keys C2518248EEA14886 && \
    apt-get update && \
    echo oracle-java${JAVA_VER}-installer shared/accepted-oracle-license-v1-1 select true | sudo /usr/bin/debconf-set-selections && \
    apt-get install -y --force-yes --no-install-recommends oracle-java${JAVA_VERSION}-installer oracle-java${JAVA_VERSION}-set-default && \
    apt-get clean && \
    rm -rf /var/cache/oracle-jdk${JAVA_VERSION}-installer


# install utilities
RUN apt-get -y install vim git sudo zip bzip2 fontconfig curl

# install node.js
RUN curl -sL https://deb.nodesource.com/setup_4.x | sudo bash -
RUN apt-get install -y nodejs unzip python g++ build-essential

# install yeoman
RUN npm install -g yo bower grunt-cli

# install JHipster
RUN npm install -g generator-jhipster@2.23.0

# configure the "jhipster" and "root" users
RUN groupadd jhipster && useradd jhipster -s /bin/bash -m -g jhipster -G jhipster && adduser jhipster sudo
RUN echo 'jhipster:jhipster' |chpasswd

# install the sample app to download all Maven dependencies
RUN cd /home/jhipster && \
    wget https://github.com/jhipster/jhipster-sample-app/archive/v2.23.0.zip && \
    unzip v2.23.0.zip && \
    rm v2.23.0.zip
RUN cd /home/jhipster/jhipster-sample-app-2.23.0 && npm install
RUN cd /home && chown -R jhipster:jhipster /home/jhipster
# RUN cd /home/jhipster/jhipster-sample-app-2.23.0
# RUN sudo -u jhipster mvn dependency:go-offline
RUN ln -s /home/jhipster/jhipster-sample-app-2.23.0 /home/jhipster/jhipster-sample-app

RUN echo "If you can see this, the docker container is running. To run the container in daemon mode use -d while running the container." > /home/jhipster/jhipster.info

# expose the working directory, the Tomcat port, the BrowserSync ports
VOLUME ["/home/jhipster/app"]
EXPOSE 8080 3000 3001
CMD    ["tail", "-f", "/home/jhipster/jhipster.info"]
