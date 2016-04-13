## Prerequisite
  - git client installed
  - docker installed (https://www.docker.com/)
  - mongodb running version: 2.6.4 (https://www.mongodb.com/) but it worked with the latest version
  - rabbitmq running version: 3.0.2 erlang version : 5.9.1 (15B03) (http://www.rabbitmq.com/)

Download files using: git clone https://github.com/n10n/DockerNode.git

## Build docker image using: 

    docker build -t .

  Make a note of the Image ID
 
## Run docker image - manual process: 

    docker run -i -t -e MONGODB_HOST=IP_ADDRESS -e MONGODB_PORT=27017 --name SpliciousBKEND -p 8888:9876 ImageIDFromBuildStep /bin/bash
  
At the command prompt
    
    cd /usr/local/splicious
    ./splicious.sh start
  
## Run docker image - automated process: 

    docker run -i -t -e MONGODB_HOST=IP_ADDRESS -e MONGODB_PORT=27017 --name SpliciousBKEND -p 8888:9876 ImageIDFromBuildStep /usr/local/splicious.sh start
  
Please replace the IP_ADDRESS appropriately. To see log files, go to /usr/local/splicious/logs folder.

## Access container:

Visit the webpage http://localhost:8888/agentui/agentui.html?demo=false and if this don't work then find the mapping URL (ipaddress:port from Kitematic screen - select your container there i.e. SpliciousBKEND). For example, you may see the map like 192.168.99.100:32772 then the URL would be http://192.168.99.100:32772/agentui/agentui.html?demo=false

(https://drive.google.com/open?id=0B1NrzDY6kx1JTzdPNVFlU19xekk)
