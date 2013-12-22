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

Run The docker image, with the following options:

- Port 8080 in docker is fowarded to port 49080, which is then automatically exposed by Vagrant
- The Docker "/jhipster" folder is shared to the Vagrant "/vagrant/jhipster" folder, which is shared to your host (it's the directory you started Vagrant from)

```
docker run -v /vagrant/jhipster:/jhipster -p 49080:8080 -i -t jdubois/jhipster-docker /bin/bash
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

** Congratulations! You've launched your JHipster app inside Docker! **

On your host machine, you should be able to :

- Access the running application at [http://localhost:49080](http://localhost:49080)
- Get all the generated files inside your shared folder

As the generated files are in your shared folder, they will not be deleted if you stop your Docker container. However, if you don't want Docker to keep downloading all the Maven and NPM dependencies every time you start the container, you should commit its state.
