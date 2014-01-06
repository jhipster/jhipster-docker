Docker.io image for JHipster
=============

This repository makes a Docker "Trusted build" that is available on:

[https://index.docker.io/u/jdubois/jhipster-docker/](https://index.docker.io/u/jdubois/jhipster-docker/)

This image will allow you to run [JHipster](http://jhipster.github.io/) inside Docker.

Usage
-------

Install [Docker](https://www.docker.io/) on your machine.

Pull the JHipster Docker image: 

```
sudo docker pull jdubois/jhipster-docker
```

Create a "jhipster" folder in your home directory:

```
mkdir ~/jhipster
```

Run The docker image, with the following options:

- Port 8080 in docker is fowarded to the local port 8080
- The Docker "/jhipster" folder is shared to the local "~/jhipster" folder

```
sudo docker run -v ~/jhipster:/jhipster -p 8080:8080 -i -t jdubois/jhipster-docker /bin/bash
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

Note that if you want to use bower, as you are logged in as root, you must use:
```
bower install --allow-root
```

** Congratulations! You've launched your JHipster app inside Docker! **

On your host machine, you should be able to :

- Access the running application at [http://localhost:8080](http://localhost:8080)
- Get all the generated files inside your shared folder

As the generated files are in your shared folder, they will not be deleted if you stop your Docker container. However, if you don't want Docker to keep downloading all the Maven and NPM dependencies every time you start the container, you should commit its state.
