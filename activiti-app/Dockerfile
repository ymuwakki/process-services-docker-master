FROM alfresco/alfresco-base-tomcat:8.5.28-java-8-oracle-centos-7

# Upgrading system
RUN yum install -y \
    yum-plugin-ovl \
    unzip \
    wget

ENV ACTIVITI_APP_PROPS ${CATALINA_HOME}/lib/activiti-app.properties
ENV ACTIVITI_IDENTITY_SERVICE_PROPS ${CATALINA_HOME}/lib/activiti-identity-service.properties
ARG ACTIVITI_VERSION


# Copy custom entrypoint and properties
COPY /activiti-app/set-activiti-config.sh /activiti-app/set-activiti-identity-config.sh /activiti-app/entrypoint.sh \
     /activiti-app/get_from_s3.sh /activiti-app/download_assets.sh /root/
COPY /activiti-app/docker-activiti-app.properties ${ACTIVITI_APP_PROPS}
COPY /activiti-app/docker-activiti-identity-service.properties ${ACTIVITI_IDENTITY_SERVICE_PROPS}
COPY /activiti-app/activiti-app.war ${CATALINA_HOME}/webapps/
RUN sed -i -e 's/<secure>.*<\/secure>//' ${CATALINA_HOME}/conf/web.xml

RUN /root/download_assets.sh && \
    rm /root/download_assets.sh

WORKDIR ${CATALINA_HOME}/webapps/

RUN yum install openssl -y && \
    yum remove wget -y && \
    yum autoremove -y && \
    yum clean all

# Docker layerization is procedural. This means that each directive is a layer, executed in the sequence in which it is presented.
# If a layer changes, it invalidates all subsequent layers.
# The EXPOSE, CMD and ENV layers are the ones least likely to change and they normally remain on top to reduce build time.
EXPOSE 8080
CMD ["/root/entrypoint.sh"]
