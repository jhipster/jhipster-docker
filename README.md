Docker.io image for JHipster
=============

This repository makes a Docker "Trusted build" that is available on:

[https://index.docker.io/u/jdubois/jhipster-docker/](https://index.docker.io/u/jdubois/jhipster-docker/)

This image will allow you to run [JHipster](http://jhipster.github.io/) inside Docker.

Usage
-------

Install [Docker](https://www.docker.io/) on your machine

Be sure that your "/vagrant" folder is shared. You might need to refresh your Vagrant box:

```
vagrant halt && vagrant up
```

Connect to your Vagrant box:

```
vagrant ssh
```

Create a directory in the shared folder, in which you will develop your application (so you can access it easily from your host system):

```
mkdir /vagrant/jhipster
```

Pull the JHipster Docker image: 

```
docker pull jdubois/jhipster-docker
```

Run The docker image (the shared folder is "/jhipster" in the Docker container, and we forward port 8080 which is used by Tomcat):

```
docker run -v /vagrant/jhipster:/jhipster -p 8080:8080 -i -t jdubois/jhipster-docker /bin/bash
```

You can then go to the /jhipster directory in your container, and start building your app inside Docker:
```
cd /jhipster
yo jhipster
```

Once your application is created, you can run all the normal grunt/bower/maven commands, for example:
```
mvn tomcat7:run
```

On your host machine, you should be able to access the running application. And all the generated files should be available in your shared folder.
