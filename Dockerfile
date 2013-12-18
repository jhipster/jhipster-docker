# DOCKER-VERSION 0.7.1
FROM      ubuntu:12.04
MAINTAINER Julien Dubois <julien.dubois@gmail.com>

# make sure the package repository is up to date
RUN echo "deb http://archive.ubuntu.com/ubuntu precise main universe" > /etc/apt/sources.list
RUN apt-get -y update

# install net tools
RUN apt-get -y -f install curl net-tools

# Install SSH daemon
RUN apt-get install -y openssh-server
RUN mkdir /var/run/sshd
RUN echo "root:jhipster" | chpasswd
EXPOSE 22
RUN /usr/sbin/sshd

# Install MySQL
RUN apt-get install -y mysql-server
RUN apt-get clean
EXPOSE 3306

# install python-software-properties (so you can do add-apt-repository)
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y -q python-software-properties

# install oracle java from PPA
RUN add-apt-repository ppa:webupd8team/java -y
RUN apt-get update
RUN echo oracle-java7-installer shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections
RUN apt-get install -y oracle-java7-installer

# Set oracle java as the default java
RUN update-java-alternatives -s java-7-oracle

# install git
RUN apt-get -y install git

# install maven from a PPA
RUN add-apt-repository ppa:natecarlson/maven3
RUN apt-get update && apt-get install --assume-yes maven3

# install node.js from PPA
RUN add-apt-repository ppa:chris-lea/node.js
RUN apt-get install -y nodejs

# install yeoman
RUN npm install -g yo

# install JHipster
RUN npm install -g generator-jhipster

# Launch JHipster
CMD ["yo", "jhipster"]
