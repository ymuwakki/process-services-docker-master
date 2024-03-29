#!/bin/sh

activiti_app_properties=$ACTIVITI_APP_PROPS

if [ -n "$EXTERNAL_ACTIVITI_APP_PROPERTIES_FILE" ]
then
  echo "Using external config file for activiti app"
  curl $EXTERNAL_ACTIVITI_APP_PROPERTIES_FILE -o $ACTIVITI_APP_PROPS
elif [[ (-n "$S3_BUCKET_WITH_ROLE") && (-n "$EXTERNAL_PROPERTIES_ACTIVITI_OBJECT_NAME") && (-n "$ACTIVITI_BUCKET_NAME") ]]
then
  echo "Trying to fetch the activiti app properties from the bucket $ACTIVITI_BUCKET_NAME"
  $HOME/get_from_s3.sh $EXTERNAL_PROPERTIES_ACTIVITI_OBJECT_NAME $ACTIVITI_BUCKET_NAME $ACTIVITI_APP_PROPS
else
  echo "Using default activiti config file"
  test -n "$ACTIVITI_LICENSE_MULTI_TENANT" && sed -i "s|^\(license\.multi\-tenant\s*=\s*\).*\$|\1$ACTIVITI_LICENSE_MULTI_TENANT|" $activiti_app_properties
  test -n "$ACTIVITI_DATASOURCE_URL" && sed -i "s|^\(datasource\.url\s*=\s*\).*\$|\1$ACTIVITI_DATASOURCE_URL|" $activiti_app_properties
  test -n "$ACTIVITI_DATASOURCE_DRIVER" && sed -i "s/^\(datasource\.driver\s*=\s*\).*\$/\1$ACTIVITI_DATASOURCE_DRIVER/" $activiti_app_properties
  test -n "$ACTIVITI_DATASOURCE_USERNAME" && sed -i "s/^\(datasource\.username\s*=\s*\).*\$/\1$ACTIVITI_DATASOURCE_USERNAME/" $activiti_app_properties
  test -n "$ACTIVITI_DATASOURCE_PASSWORD" && sed -i "s/^\(datasource\.password\s*=\s*\).*\$/\1$ACTIVITI_DATASOURCE_PASSWORD/" $activiti_app_properties
  test -n "$ACTIVITI_HIBERNATE_DIALECT" && sed -i "s/^\(hibernate\.dialect\s*=\s*\).*\$/\1$ACTIVITI_HIBERNATE_DIALECT/" $activiti_app_properties
  test -n "$ACTIVITI_ADMIN_EMAIL" && sed -i "s/^\(admin\.email\s*=\s*\).*\$/\1$ACTIVITI_ADMIN_EMAIL/" $activiti_app_properties
  test -n "$ACTIVITI_ADMIN_PASSWORD_HASH" && sed -i "s/^\(admin\.passwordHash\s*=\s*\).*\$/\1$ACTIVITI_ADMIN_PASSWORD_HASH/" $activiti_app_properties
  test -n "$ACTIVITI_ES_SERVER_TYPE" && sed -i "s/^\(elastic\-search\.server\.type\s*=\s*\).*\$/\1$ACTIVITI_ES_SERVER_TYPE/" $activiti_app_properties
  test -n "$ACTIVITI_ES_DISCOVERY_HOSTS" && sed -i "s/^\(elastic\-search\.discovery\.hosts\s*=\s*\).*\$/\1$ACTIVITI_ES_DISCOVERY_HOSTS/" $activiti_app_properties
  test -n "$ACTIVITI_ES_CLUSTER_NAME" && sed -i "s/^\(elastic\-search\.cluster\.name\s*=\s*\).*\$/\1$ACTIVITI_ES_CLUSTER_NAME/" $activiti_app_properties
  test -n "$ACTIVITI_ES_REST_CLIENT_PORT" && sed -i "s/^\(elastic\-search\.rest\-client\.port\s*=\s*\).*\$/\1$ACTIVITI_ES_REST_CLIENT_PORT/" $activiti_app_properties
  test -n "$ACTIVITI_ES_REST_CLIENT_ADDRESS" && sed -i "s/^\(elastic\-search\.rest\-client\.address\s*=\s*\).*\$/\1$ACTIVITI_ES_REST_CLIENT_ADDRESS/" $activiti_app_properties
  test -n "$ACTIVITI_ES_REST_CLIENT_CONNECT_TIMEOUT" && sed -i "s/^\(elastic\-search\.rest\-client\.connect\-timeout\s*=\s*\).*\$/\1$ACTIVITI_ES_REST_CLIENT_CONNECT_TIMEOUT/" $activiti_app_properties
  test -n "$ACTIVITI_ES_REST_CLIENT_SOCKET_TIMEOUT" && sed -i "s/^\(elastic\-search\.rest\-client\.socket\-timeout\s*=\s*\).*\$/\1$ACTIVITI_ES_REST_CLIENT_SOCKET_TIMEOUT/" $activiti_app_properties
  test -n "$ACTIVITI_CORS_ENABLED" && sed -i "s/^\(cors\.enabled\s*=\s*\).*\$/\1$ACTIVITI_CORS_ENABLED/" $activiti_app_properties
  test -n "$ACTIVITI_CORS_ALLOWED_ORIGINS" && sed -i "s/^\(cors\.allowed\.origins\s*=\s*\).*\$/\1$ACTIVITI_CORS_ALLOWED_ORIGINS/" $activiti_app_properties
  test -n "$ACTIVITI_CORS_ALLOWED_METHODS" && sed -i "s/^\(cors\.allowed\.methods\s*=\s*\).*\$/\1$ACTIVITI_CORS_ALLOWED_METHODS/" $activiti_app_properties
  test -n "$ACTIVITI_CORS_ALLOWED_HEADERS" && sed -i "s/^\(cors\.allowed\.headers\s*=\s*\).*\$/\1$ACTIVITI_CORS_ALLOWED_HEADERS/" $activiti_app_properties
  test -n "$ACTIVITI_CSRF_DISABLED" && sed -i "s/^\(security\.csrf\.disabled\s*=\s*\).*\$/\1$ACTIVITI_CSRF_DISABLED/" $activiti_app_properties
  test -n "$ACTIVITI_CONTENTSTORAGE_S3_BUCKETNAME" && sed -i "s/^\(contentstorage\.s3\.bucketname\s*=\s*\).*\$/\1$ACTIVITI_CONTENTSTORAGE_S3_BUCKETNAME/" $activiti_app_properties
  test -n "$ACTIVITI_VALIDATOR_EDITOR_BPMN_DISABLE_SCRIPTTASK" && sed -i "s/^\(validator\.editor\.bpmn\.disable\.scripttask\s*=\s*\).*\$/\1$ACTIVITI_VALIDATOR_EDITOR_BPMN_DISABLE_SCRIPTTASK/" $activiti_app_properties
  test -n "$ACTIVITI_VALIDATOR_EDITOR_BPMN_DISABLE_SCRIPTTASK_GROOVY" && sed -i "s/^\(validator\.editor\.bpmn\.disable\.scripttask\.groovy\s*=\s*\).*\$/\1$ACTIVITI_VALIDATOR_EDITOR_BPMN_DISABLE_SCRIPTTASK_GROOVY/" $activiti_app_properties
  test -n "$SOCIUM_ALFRESCO_ACS_ENDPOINT" && sed -i "s/^\(socium\.alfresco\.acs\.endpoint\s*=\s*\).*\$/\1$SOCIUM_ALFRESCO_ACS_ENDPOINT/" $activiti_app_properties
fi
