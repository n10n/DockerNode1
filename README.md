## Prerequisite
  - git client installed and git command in path
  - docker installed (https://www.docker.com/) and running (start using Docker Quick Terminal and make a note of the IP address assigned for example 192.168.99.100)
  - mongodb running version: 2.6.4 (https://www.mongodb.com/) but it worked with the latest version
  - rabbitmq running version: 3.0.2 erlang version : 5.9.1 (15B03) (http://www.rabbitmq.com/)

Download files in a directory of your choice to build Docker image and make sure docker is available: 

    1. git clone https://github.com/n10n/DockerNode.git SpliciousBKND

## Build docker image using: 
Run the following command 

    2a. cd SpliciousBKND
    2b. docker build .

  Make a note of the Image ID and follow either manual or automated process step 3a
 
## Run docker image - manual process: 

    3a. docker run -i -t -e MONGODB_HOST=IP_ADDRESS -e MONGODB_PORT=27017 --name SpliciousBKEND -p 8888:9876 ImageIDFromBuildStep /bin/bash
  
At the # command prompt
    
    3b. cd /usr/local/splicious
    3c. ./splicious.sh start
  
## Run docker image - automated process: 

    3a. docker run -i -t -e MONGODB_HOST=IP_ADDRESS -e MONGODB_PORT=27017 \
              --name SpliciousBKEND -p 8888:9876 ImageIDFromBuildStep \
              /usr/local/splicious/splicious.sh start
  
Please replace the IP_ADDRESS appropriately. To see log files, go to /usr/local/splicious/logs folder.

## Access container:

Visit the webpage http://<docker_quick_terminal_assigned_IP>:8888/agentui/agentui.html?demo=false and if this don't work then find the mapping URL (ipaddress:port from Kitematic screen - select your container there i.e. SpliciousBKEND). For example, you may see the map like 192.168.99.100:32772 then the URL would be http://192.168.99.100:32772/agentui/agentui.html?demo=false or http://192.168.99.100:8888/agentui/agentui.html?demo=false

See screenshot 
https://drive.google.com/open?id=0B1NrzDY6kx1JTzdPNVFlU19xekk

## Other notes:

To save a container to be used as an image

    docker commit [container_id] [name_in_lowercase]

To save an image to use in different docker installation

    docker save [name_in_lowercase] > [directory_location_to_save]/[image_name].tar

To load an image created in different docker installation 

    docker load < [image_name].tar
