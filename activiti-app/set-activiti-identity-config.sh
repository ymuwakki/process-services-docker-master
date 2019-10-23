#!/bin/sh

activiti_identity_service_properties=$ACTIVITI_IDENTITY_SERVICE_PROPS

if [ -n "$EXTERNAL_ACTIVITI_IDENTITY_SERVICE_PROPERTIES_FILE" ]
then
  echo "Using external activiti identity config file"
  curl $EXTERNAL_ACTIVITI_IDENTITY_SERVICE_PROPERTIES_FILE -o $ACTIVITI_IDENTITY_SERVICE_PROPS
elif [[ (-n "$S3_BUCKET_WITH_ROLE") && (-n "$EXTERNAL_PROPERTIES_IDENTITY_OBJECT_NAME")&& (-n "$IDENTITY_BUCKET_NAME") ]]
then
  echo "Trying to fetch the activiti identity properties from the bucket $BUCKET_NAME"
  $HOME/get_from_s3.sh $EXTERNAL_PROPERTIES_IDENTITY_OBJECT_NAME $IDENTITY_BUCKET_NAME $ACTIVITI_IDENTITY_SERVICE_PROPS
else
  echo "Using default activiti identity service config file"
  test -n "$IDENTITY_SERVICE_ENABLED" && sed -i "s/^\(keycloak\.enabled\s*=\s*\).*\$/\1$IDENTITY_SERVICE_ENABLED/" $activiti_identity_service_properties
  test -n "$IDENTITY_SERVICE_REALM" && sed -i "s/^\(keycloak\.realm\s*=\s*\).*\$/\1$IDENTITY_SERVICE_REALM/" $activiti_identity_service_properties
  test -n "$IDENTITY_SERVICE_AUTH" && sed -i "s|^\(keycloak\.auth-server-url\s*=\s*\).*\$|\1$IDENTITY_SERVICE_AUTH|" $activiti_identity_service_properties
  test -n "$IDENTITY_SERVICE_SSL_REQUIRED" && sed -i "s/^\(keycloak\.ssl-required\s*=\s*\).*\$/\1$IDENTITY_SERVICE_SSL_REQUIRED/" $activiti_identity_service_properties
  test -n "$IDENTITY_SERVICE_RESOURCE" && sed -i "s/^\(keycloak\.resource\s*=\s*\).*\$/\1$IDENTITY_SERVICE_RESOURCE/" $activiti_identity_service_properties
  test -n "$IDENTITY_SERVICE_PRINCIPAL_ATTRIBUTE" && sed -i "s/^\(keycloak\.principal-attribute\s*=\s*\).*\$/\1$IDENTITY_SERVICE_PRINCIPAL_ATTRIBUTE/" $activiti_identity_service_properties
  test -n "$IDENTITY_SERVICE_ALWAYS_REFRESH_TOKEN" && sed -i "s/^\(keycloak\.always-refresh-token\s*=\s*\).*\$/\1$IDENTITY_SERVICE_ALWAYS_REFRESH_TOKEN/" $activiti_identity_service_properties
  test -n "$IDENTITY_SERVICE_AUTODETECT_BEARER_ONLY" && sed -i "s/^\(keycloak\.autodetect-bearer-only\s*=\s*\).*\$/\1$IDENTITY_SERVICE_AUTODETECT_BEARER_ONLY/" $activiti_identity_service_properties
  test -n "$IDENTITY_SERVICE_TOKEN_STORE" && sed -i "s/^\(keycloak\.token-store\s*=\s*\).*\$/\1$IDENTITY_SERVICE_TOKEN_STORE/" $activiti_identity_service_properties
  test -n "$IDENTITY_SERVICE_ENABLE_BASIC_AUTH" && sed -i "s/^\(keycloak\.enable-basic-auth\s*=\s*\).*\$/\1$IDENTITY_SERVICE_ENABLE_BASIC_AUTH/" $activiti_identity_service_properties
  test -n "$IDENTITY_SERVICE_PUBLIC_CLIENT" && sed -i "s/^\(keycloak\.public-client\s*=\s*\).*\$/\1$IDENTITY_SERVICE_PUBLIC_CLIENT/" $activiti_identity_service_properties
  test -n "$IDENTITY_CREDENTIALS_SECRET" && sed -i "s/^\(keycloak\.credentials.secret\s*=\s*\).*\$/\1$IDENTITY_CREDENTIALS_SECRET/" $activiti_identity_service_properties
fi