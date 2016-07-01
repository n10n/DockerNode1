
## Synereo Node Dockerfile

Dockerfile for easily setting up a node and instructions are for building backend from pre-compipled source code. This process will take around 25-40 minutes to download around 600 MB of data. These instructions are valid for first time use and once docker images are created and working then use `docker start ...` command. This build image contains older version of UI (i.e. Splicious UI) and newer version of Synereo UI.

## Prerequisites
 * Minimum 2GB RAM but 4 GB RAM is recommended for compling the source code.
 * Basic knowledge of Docker. Docker installed (https://www.docker.com/) and running Docker process. Using  [Kitematic](https://docs.docker.com/kitematic/) to start the docker process is very helpful and advisable if using Windows or Mac. On modern linux kernel based system, such as Arch Linux, you can just use plain [Docker](https://wiki.archlinux.org/index.php/Docker). Make a note of assigned IP address when starting up Docker and for example, in Windows and Mac, assigned IP address is 192.168.99.100. If want to use existing Docker image to run backend (preferred method) then use the image from Docker hub using `docker pull livelygig/backend` after that jump to 'Running' section below and change the docker image to `livelygig/backend` from `spliciousbkendimage` in docker run commands below. Please follow detailed instruction to run pre-built image at https://github.com/synereo/dockernode/wiki/Running-Pre-built-Image.  
  
  [https://hub.docker.com/r/livelygig/backend/](https://hub.docker.com/r/livelygig/backend/)
  
  MongoDB is required to run a standalone node. MongoDB and RabbitMQ are required to run a full node. 
  
 * git client installed and git command in path if want to build the node from scratch otherwise use Docker image (preferred method)
 * mongodb running version: 2.6.4 (https://www.mongodb.com/) but it worked with the latest version. MongoDB is installed as part of installation steps. Importing old MongoDB database dump from different node is not advisable.

## Source files
Download files in a directory of your choice or use command as below to build Docker image (make sure docker is running and available). Windows users, run "git config --global core.autocrlf false" command before running the git clone command otherwise container may fail to execute properly.

    1. git clone -b ubuntu https://github.com/n10n/DockerNode.git SNode

## Build docker image using: 
Run the following commands

    2a. cd SNode
    2b. docker build -t scoremongonode . 

  Use "scoremongonode" as image name in subsequent steps where image id is required. You can use image name of your choice but it must be all lowercase. 
 
## Running standalone node:
Standalone mode requires running MongoDB and please replace the IP_ADDRESS (this address is accquired by docker and displays at starting of it i.e. 192.168.99.100 in Windows and Mac) appropriately below. If you are using pre-built image from Docker Hub i.e. livelygig/backend then replace the following field in docker run command below:
    `replace IP_ADDRESS with: 192.168.99.100` and `replace spliciousbkendimage with: livelygig/backend` 

#### Running docker image - manual process: 

    3a. docker run -it -e DB_HOST=127.0.0.1 \
                   --name scmn1 -p 80:9000 -p 8080:9876 scoremongonode /bin/bash
  
At the # prompt, run the commands below and these will start OmniCored, MongoDB and Splciious
    
    3b. cd /usr/local/mongodb
    3c. ./mstart.sh
    3d. cd /usr/local/omnicore
    3e. ./ostart.sh
    3f. cd /usr/local/splicious
    3g. bin/splicious start

## Accessing container:

Visit the webpage `http://<docker_IP>:8080/agentui/agentui.html?demo=false` and if this doesn't work then find the mapping URL (ipaddress:port from Kitematic screen - select your container there i.e. backendNode). For example, you may see the access URL like 192.168.99.100:8888 then access the backend using http://192.168.99.100:8888/agentui/agentui.html?demo=false URL

The default user name/password is admin@localhost/a and can be changed in /usr/local/splicious/eval.conf file by editing `nodeAdminEmail` and `nodeAdminPass` or add NODEADMINEMAIL and NODEADMINPASS to docker run command. For example:
  ```
  docker run -it --link mdb1:mongo \
                 -e NODEADMINEMAIL=runforfun@localhost \
                 -e NODEADMINPASS=FunNeverEnds2016 \
                 -e DB_HOST=127.0.0.1 \
                 -p 80:9000 \
                 -p 8080:9876 --name backendNode \
                 scoremongonode /bin/bash
  ```
See screenshot 
https://drive.google.com/open?id=0B1NrzDY6kx1JTzdPNVFlU19xekk. To see log files, go to /usr/local/splicious/logs folder after login into the container.
