## Prerequisite
  - git client installed
  - docker installed (https://www.docker.com/)
  - mongodb running version: 2.6.4 (https://www.mongodb.com/) but it worked with the latest version
  - rabbitmq running version: 3.0.2 erlang version : 5.9.1 (15B03) (http://www.rabbitmq.com/)

Download files using: git clone https://github.com/n10n/DockerNode.git

## Build docker image using: 

  * docker build -t .

Make a note of the Image ID
 
## Run docker image - manual process: 

  * docker run -i -t -e MONGODB_HOST=IP_ADDRESS -e MONGODB_PORT=27017 -p 8888:9876 ImageIDFromBuildStep /bin/bash

  At the command prompt
  * cd /usr/local/splicious
  * ./splicious.sh start
  
## Run docker image - automated process: 
  * docker run -i -t -e MONGODB_HOST=IP_ADDRESS -e MONGODB_PORT=27017 -p 8888:9876 ImageIDFromBuildStep /usr/local/splicious.sh start
  
Please replace the IP_ADDRESS appropriately. To see log files go to /usr/local/splicious/logs folder.

## Access container

Visit the webpage http://localhost:8888/agentui/agentui.html?demo=false or find the mapping URL and port from Kitematic screen (select your container it from there) for example: http://192.168.99.100:32772/agentui/agentui.html?demo=false
