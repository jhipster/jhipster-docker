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

- The Docker "/jhipster" folder is shared to the local "~/jhipster" folder
- Forward all ports exposed by docker (8080 for Tomcat, 9000 for the Grunt server, 22 for SSHD). In the following example we forward the container 22 port to the host 4022 port, to prevent some port conflicts:

```
sudo docker run -v ~/jhipster:/jhipster -p 8080:8080 -p 9000:9000 -p 4022:22 -t jdubois/jhipster-docker
```

You can now connect to your docker container with SSH. You can connect as "root/jhipster" or as "jhipster/jhipster", and we recommand you use the "jhipster" user as some of the tool used are not meant to be run by the root user.

Start by adding your SSH public key to the Docker container:
```
cat .ssh/id_rsa.pub | ssh -p 4022 jhipster@localhost 'mkdir .ssh && cat >> .ssh/authorized_keys'
```

You can now connect to the Docker container:
```
ssh -p 4022 jhipster@localhost
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

- Access the running application at [http://localhost:8080](http://localhost:8080)
- Get all the generated files inside your shared folder

As the generated files are in your shared folder, they will not be deleted if you stop your Docker container. However, if you don't want Docker to keep downloading all the Maven and NPM dependencies every time you start the container, you should commit its state.
