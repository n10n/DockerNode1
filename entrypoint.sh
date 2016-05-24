#!/bin/sh

EVAL_FILE=$W_DIR/splicious/config/eval.conf
UISH_FILE=$W_DIR/frontui/frontui.sh
UIAPP_FILE=$W_DIR/frontui/conf/application.conf

#ENV NODEADMINEMAIL admin@localhost
#ENV NODEADMINPASS a

#ENV API_HOST "127.0.0.1"
#ENV API_PORT "9876"
#ENV RUNB_PORT 9876
#ENV RUNF_PORT 9000

#DEPLOYMENT_MODE=colocated
#DB_HOST=127.0.0.1
#DB_PORT=27017
#DSLSERVER=127.0.0.1
#DSLPORT=5672
#BFCLSERVER=127.0.0.1
#BFCLPORT=5672
#DSLEPSSERVER=127.0.0.1
#DSLEPSPORT=5672

## UI
#update backend server 
sed -i 's/baseURL: \"http:\/\/localhost:9876\/api\"/baseURL: \"http:\/\/'$API_HOST':'$API_PORT'\/api\"/' $UIAPP_FILE

#update running port
sed -i 's/http.port=9000/http.port='$RUNF_PORT'/' $UISH_FILE

## Backend
#Node Admin
sed -i 's/nodeAdminEmail = \"admin@localhost\"/nodeAdminEmail = \"'$NODEADMINEMAIL'\"/' $EVAL_FILE
sed -i 's/nodeAdminPass = \"a\"/nodeAdminPass = \"'$NODEADMINPASS'\"/' $EVAL_FILE

#MongdoDB
sed -i 's/dbHost = \"127.0.0.1\"/dbHost = \"'$DB_HOST'\"/' $EVAL_FILE
sed -i 's/dbPort = \"27017\"/dbPort = \"'$DB_PORT'\"/' $EVAL_FILE

#DeploymentMode
sed -i 's/deploymentMode = \"colocated\"/deploymentMode = \"'$DEPLOYMENT_MODE'\"/' $EVAL_FILE
#DSLCommLinkServer
sed -i 's/DSLCommLinkServerHost = \"127.0.0.1\"/DSLCommLinkServerHost = \"'$DSLSERVER'\"/' $EVAL_FILE
#sed -i 's/DSLCommLinkServerPort = \"5672\"/DSLCommLinkServerPort = \"'$DSLPORT'\"/' $EVAL_FILE
sed -i 's/DSLCommLinkServerPort = 5672/DSLCommLinkServerPort = \"'$DSLPORT'\"/' $EVAL_FILE
#BFactoryCommLinkServer
sed -i 's/BFactoryCommLinkServerHost = \"127.0.0.1\"/BFactoryCommLinkServerHost = \"'$BFCLSERVER'\"/' $EVAL_FILE
#sed -i 's/BFactoryCommLinkServerPort = \"5672\"/BFactoryCommLinkServerPort = \"'$BFCLPORT'\"/' $EVAL_FILE
sed -i 's/BFactoryCommLinkServerPort = 5672/BFactoryCommLinkServerPort = \"'$BFCLPORT'\"/' $EVAL_FILE
#DSLEvaluatorPreferredSupplier
sed -i 's/DSLEvaluatorPreferredSupplierHost = \"127.0.0.1\"/DSLEvaluatorPreferredSupplierHost = \"'$DSLEPSSERVER'\"/' $EVAL_FILE
#sed -i 's/DSLEvaluatorPreferredSupplierPort = \"5672\"/DSLEvaluatorPreferredSupplierPort = \"'$DSLEPSPORT'\"/' $EVAL_FILE
sed -i 's/DSLEvaluatorPreferredSupplierPort = 5672/DSLEvaluatorPreferredSupplierPort = \"'$DSLEPSPORT'\"/' $EVAL_FILE
exec "$@"
