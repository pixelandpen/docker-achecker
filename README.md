# December 2018 Update

This is a major rewrite of the previous version, as AChecker now 
requires PHP7+ and Composer. It uses the `ubuntu:18.04` base image
instead of the `tutum/lamp` image used previously. 

This project is for local testing purposes only and should 
NOT BE USED IN A PRODUCTION environment as the security defaults
are severely lacking. 

# AChecker Docker setup

## Setup MySQL password

The container runs a local instance of MySQL. A default password is set
in the `debconf.selections` file. Change the password to something of
your choosing, if desired.

## Build AChecker Docker image

```
docker build -t pixelandpen/achecker .
```

## Run AChecker Docker container 

```
docker run -d -p 8000:80 -p 3306:3306 --name achecker pixelandpen/achecker
```

## Install AChecker on Docker container

Open your browser of choice and go to `http://localhost:8000/achecker/nstall`, and
follow the installation instructions.

The database username is `root` and the password is what you created
in `debconf.selections`.

