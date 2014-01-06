# DOCKER-VERSION 0.7.1
FROM      ubuntu:12.04
MAINTAINER Julien Dubois <julien.dubois@gmail.com>

# make sure the package repository is up to date
RUN echo "deb http://archive.ubuntu.com/ubuntu precise main universe" > /etc/apt/sources.list
RUN apt-get -y update

# install python-software-properties (so you can do add-apt-repository)
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y -q python-software-properties

# install oracle java from PPA
RUN add-apt-repository ppa:webupd8team/java -y
RUN apt-get update
RUN echo oracle-java7-installer shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections
RUN apt-get install -y oracle-java7-installer && apt-get clean

# Set oracle java as the default java
RUN update-java-alternatives -s java-7-oracle
RUN echo "export JAVA_HOME=/usr/lib/jvm/java-7-oracle" >> ~/.bashrc

# install utilities
RUN apt-get -y install vim git sudo zip bzip2 fontconfig

# install maven from a PPA
RUN add-apt-repository ppa:natecarlson/maven3
RUN apt-get update && apt-get install --assume-yes maven3
RUN ln -s /usr/share/maven3/bin/mvn /usr/bin/mvn

# install node.js from PPA
RUN add-apt-repository ppa:chris-lea/node.js
RUN apt-get update
RUN apt-get install -y nodejs

# install yeoman
RUN npm install -g yo

# install JHipster
RUN npm install -g generator-jhipster

# create the "jhipster" user and install the sample app to download all Maven, NPM and Bower dependencies
RUN groupadd jhipster && useradd jhipster -s /bin/bash -m -g jhipster -G jhipster && adduser jhipster sudo
RUN echo 'jhipster:jhipster' |chpasswd

RUN cd /jhipster && \
    wget https://github.com/jhipster/jhipster-sample-app/archive/v0.6.1.1.zip && \
    unzip v0.6.1.1.zip && \
    rm v0.6.1.1.zip
RUN cd /jhipster/jhipster-sample-app-0.6.1.1 && npm install
RUN cd / && chown -R jhipster:jhipster /jhipster
RUN cd /jhipster/jhipster-sample-app-0.6.1.1 && sudo -u jhipster mvn dependency:go-offline
RUN cd /jhipster/jhipster-sample-app-0.6.1.1 && su - jhipster -c "cd jhipster-sample-app && mvn -Pprod package"

WORKDIR /jhipster

# expose the working directory and the Tomcat port
VOLUME ["/jhipster"]
EXPOSE 8080
