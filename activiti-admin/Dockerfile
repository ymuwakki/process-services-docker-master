FROM alfresco/alfresco-base-tomcat:8.5.28-java-8-oracle-centos-7

# Upgrading system
RUN yum install -y \
    yum-plugin-ovl \
    unzip \
    wget

ARG ACTIVITI_VERSION
ENV ACTIVITI_ADMIN_PROPS ${CATALINA_HOME}/lib/activiti-admin.properties

# Copy custom entrypoint and properties
COPY /activiti-admin/set-activiti-admin-config.sh /activiti-admin/entrypoint.sh /activiti-admin/get_from_s3.sh /activiti-admin/download_assets.sh /root/
COPY /activiti-admin/docker-activiti-admin.properties ${ACTIVITI_ADMIN_PROPS}
COPY /activiti-admin/activiti-admin.war ${CATALINA_HOME}/webapps/
RUN sed -i -e 's/<secure>.*<\/secure>//' ${CATALINA_HOME}/conf/web.xml

RUN /root/download_assets.sh && \
    rm /root/download_assets.sh

RUN yum install openssl -y && \
    yum remove wget -y && \
    yum autoremove -y && \
    yum clean all

# Docker layerization is procedural. This means that each directive is a layer, executed in the sequence in which it is presented.
# If a layer changes, it invalidates all subsequent layers.
# The EXPOSE, CMD and ENV layers are the ones least likely to change and they normally remain on top to reduce build time.
EXPOSE 8080

CMD ["/root/entrypoint.sh"]
