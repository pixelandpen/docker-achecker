# AChecker Docker setup

## Build AChecker Docker image

```
docker build -t pixelandpen/achecker .
```

## Run AChecker Docker container 

```
docker run -d -p 8000:80 -p 3306:3306 --name achecker pixelandpen/achecker
```

## Install AChecker on Docker container

Open your browser of choice and go to `http://localhost:8000/install`, and
follow the installation instructions.

### MySQL database info

You will need to retrieve the MySQL admin password for setting up the database connection.

```
docker logs achecker 
```

Viewing the docker logs will show something like:

```
=> An empty or uninitialized MySQL volume is detected in /var/lib/mysql
=> Installing MySQL ...
=> Done!
=> Waiting for confirmation of MySQL service startup
=> Creating MySQL admin user with random password
=> Done!
========================================================================
You can now connect to this MySQL Server using:

    mysql -uadmin -p0dxosCagrXhb -h<host> -P<port>

    Please remember to change the above password as soon as possible!
    MySQL user 'root' has no password but only allows local connections
    ========================================================================
```

In this example, the user is `admin` and the password is `0dxosCagrXhb`.


