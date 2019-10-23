#!/bin/sh

activiti_admin_properties=$ACTIVITI_ADMIN_PROPS

if [ -n "$ACTIVITI_ADMIN_EXTERNAL_PROPERTIES_FILE" ]
then
  echo "Using external config file"
  curl $ACTIVITI_ADMIN_EXTERNAL_PROPERTIES_FILE -o $ACTIVITI_ADMIN_PROPS
elif [ -n "$S3_BUCKET_WITH_ROLE" ]
then
  echo "Trying to fetch the properties from the bucket $BUCKET_NAME"
  $HOME/get_from_s3.sh $EXTERNAL_PROPERTIES_OBJECT_NAME $BUCKET_NAME $ACTIVITI_ADMIN_PROPS
else
  echo "Using normal config file"
  test -n "$ACTIVITI_ADMIN_DATASOURCE_URL" && sed -i "s|^\(datasource\.url\s*=\s*\).*\$|\1$ACTIVITI_ADMIN_DATASOURCE_URL|" $activiti_admin_properties
  test -n "$ACTIVITI_ADMIN_DATASOURCE_DRIVER" && sed -i "s/^\(datasource\.driver\s*=\s*\).*\$/\1$ACTIVITI_ADMIN_DATASOURCE_DRIVER/" $activiti_admin_properties
  test -n "$ACTIVITI_ADMIN_DATASOURCE_USERNAME" && sed -i "s/^\(datasource\.username\s*=\s*\).*\$/\1$ACTIVITI_ADMIN_DATASOURCE_USERNAME/" $activiti_admin_properties
  test -n "$ACTIVITI_ADMIN_DATASOURCE_PASSWORD" && sed -i "s/^\(datasource\.password\s*=\s*\).*\$/\1$ACTIVITI_ADMIN_DATASOURCE_PASSWORD/" $activiti_admin_properties
  test -n "$ACTIVITI_ADMIN_HIBERNATE_DIALECT" && sed -i "s/^\(hibernate\.dialect\s*=\s*\).*\$/\1$ACTIVITI_ADMIN_HIBERNATE_DIALECT/" $activiti_admin_properties
  test -n "$ACTIVITI_ADMIN_REST_APP_HOST" && sed -i "s/^\(rest\.app\.host\s*=\s*\).*\$/\1$ACTIVITI_ADMIN_REST_APP_HOST/" $activiti_admin_properties
  test -n "$ACTIVITI_ADMIN_REST_APP_PORT" && sed -i "s/^\(rest\.app\.port\s*=\s*\).*\$/\1$ACTIVITI_ADMIN_REST_APP_PORT/" $activiti_admin_properties
  test -n "$ACTIVITI_ADMIN_REST_APP_USERNAME" && sed -i "s/^\(rest\.app\.user\s*=\s*\).*\$/\1$ACTIVITI_ADMIN_REST_APP_USERNAME/" $activiti_admin_properties
  test -n "$ACTIVITI_ADMIN_REST_APP_PASSWORD" && sed -i "s/^\(rest\.app\.password\s*=\s*\).*\$/\1$ACTIVITI_ADMIN_REST_APP_PASSWORD/" $activiti_admin_properties
fi