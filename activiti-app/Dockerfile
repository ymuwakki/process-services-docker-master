FROM alfresco/alfresco-base-tomcat:8.5.28-java-8-oracle-centos-7

# Upgrading system
RUN yum install -y \
    yum-plugin-ovl \
    unzip \
    wget \
    pwd

ENV ACTIVITI_APP_PROPS ${CATALINA_HOME}/lib/activiti-app.properties
ENV ACTIVITI_IDENTITY_SERVICE_PROPS ${CATALINA_HOME}/lib/activiti-identity-service.properties
ARG ACTIVITI_VERSION


# Copy custom entrypoint and properties
COPY activiti-app/set-activiti-config.sh activiti-app/set-activiti-identity-config.sh activiti-app/entrypoint.sh \
     activiti-app/get_from_s3.sh activiti-app/download_assets.sh /root/
COPY activiti-app/docker-activiti-app.properties ${ACTIVITI_APP_PROPS}
COPY activiti-app/docker-activiti-identity-service.properties ${ACTIVITI_IDENTITY_SERVICE_PROPS}
COPY activiti-app/activiti-app.war ${CATALINA_HOME}/webapps/
COPY activiti-app/artifacts/transform.lic ${CATALINA_HOME}/lib/
RUN sed -i -e 's/<secure>.*<\/secure>//' ${CATALINA_HOME}/conf/web.xml

RUN /root/download_assets.sh && \
    rm /root/download_assets.sh

WORKDIR ${CATALINA_HOME}/webapps/

RUN yum install openssl -y && \
    yum remove wget -y && \
    yum autoremove -y && \
    yum clean all


# Install Socium certs
# dod_sw_ca53.cer
# dsca.mil.cer
# root_ca_3.cer
# solers.socium.dsca.mil.cer

ARG JAVA_HOME=/usr/java/default
ARG TOMCAT_DIR=/usr/local/tomcat

RUN mkdir -p $TOMCAT_DIR/socium_certs

COPY activiti-app/artifacts/_certs/dod_sw_ca53.cer $TOMCAT_DIR/socium_certs/.
COPY activiti-app/artifacts/_certs/dsca.mil.cer $TOMCAT_DIR/socium_certs/.
COPY activiti-app/artifacts/_certs/root_ca_3.cer $TOMCAT_DIR/socium_certs/.
COPY activiti-app/artifacts/_certs/solers.socium.dsca.mil.cer $TOMCAT_DIR/socium_certs/.

RUN $JAVA_HOME/bin/keytool -importcert -noprompt -alias "dsca.mil.cer" -file $TOMCAT_DIR/socium_certs/dsca.mil.cer -storepass changeit -keystore $JAVA_HOME/jre/lib/security/cacerts
RUN $JAVA_HOME/bin/keytool -importcert -noprompt -alias "solers.socium.dsca.mil" -file $TOMCAT_DIR/socium_certs/solers.socium.dsca.mil.cer -storepass changeit -keystore $JAVA_HOME/jre/lib/security/cacerts
RUN $JAVA_HOME/bin/keytool -importcert -noprompt -alias "dod_sw_ca53" -file $TOMCAT_DIR/socium_certs/dod_sw_ca53.cer -storepass changeit -keystore $JAVA_HOME/jre/lib/security/cacerts
RUN $JAVA_HOME/bin/keytool -importcert -noprompt -alias "root_ca_3" -file $TOMCAT_DIR/socium_certs/root_ca_3.cer -storepass changeit -keystore $JAVA_HOME/jre/lib/security/cacerts

# Docker layerization is procedural. This means that each directive is a layer, executed in the sequence in which it is presented.
# If a layer changes, it invalidates all subsequent layers.
# The EXPOSE, CMD and ENV layers are the ones least likely to change and they normally remain on top to reduce build time.
EXPOSE 8080
CMD ["/root/entrypoint.sh"]
