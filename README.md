
## Backend Dockerfile

There are two way to create a node 1) compile from source code and 2) get pre compiled version of images. Dockerfile for easily setting up a node and instructions are for building backend from the source code (This takes sometime to build i.e. around 20-40 minutes). These instructions are valid for first time use and once docker images are created and working then use `docker start ...` command, for more detail see the wiki pages. This build image contains both older version of UI (i.e. Splicious UI) and newer version of Synereo UI.

## Prerequisites
 * Minimum 2GB RAM but 4 GB RAM is recommended for compling the source code.
 * Basic knowledge of Docker. Docker installed (https://www.docker.com/) and running Docker process. Using  [Kitematic](https://docs.docker.com/kitematic/) to start the docker process is very helpful and advisable if using Windows or Mac. Make a note of assigned IP address when starting up Docker and for example, in Windows and Mac, assigned IP address is 192.168.99.100. 

  MongoDB is required to run a standalone node. MongoDB and RabbitMQ are required to run a full node. 
  
 * git client installed and git command in path if want to build the node from scratch otherwise use Docker image (preferred method - WIP)
 * mongodb running version: 2.6.4 (https://www.mongodb.com/) but it worked with the latest version. Follow the instruction below if want to use Docker image. Importing old MongoDB database dump from different node is not advisable.

    `docker pull mongo` then 
    `docker run --name mdb1 -p 27017:27017 -d mongo`

## Source files
Download files in a directory of your choice or use command as below to build Docker image (make sure docker is running and available). Windows users, run "git config --global core.autocrlf false" command before running the git clone command otherwise container may fail to execute properly.

    1. git clone https://github.com/n10n/dockernode.git dockernode

## Build docker image using: 
Run the following commands

    2a. cd dockernode
    2b. docker build -t snode . 

  Use "snode" as image name in subsequent steps where image id is required. You can use image name of your choice but it must be all lowercase. 

#### Running docker image - manual process: 
Use the following command to run a container from an image i.e. "snode" as in step 2b.
  ```
  3a. docker run -it --link mdb1:mongo \
                 -e NODEADMINEMAIL=a@localhost \
                 -e NODEADMINPASS=al \
                 -e DB_HOST=192.168.99.100 \
                 -e DB_PORT=27017 \
                 -p 8888:9876 -p 80:9000 \
                 --name backendNode \
                 snode /bin/bash
  ```
  
At the # prompt, run the commands below to run backend
    
    3b. cd /usr/local/splicious
    3c. ./splicious.sh start

At the # prompt, run the commands below to run frontui
  
    4b. cd /usr/local/frontui
    4c. ./frontui.sh start

If want to stop the server run above commands with stop argument i.e. ` ./splicious.sh stop` and ` ./frontui.sh stop`

## Accessing container:
```
http://192.168.99.100:8888/agentui/agentui.html
http://192.168.99.100:80/
```
