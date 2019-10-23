# What is Alfresco Process services

[Alfresco Process Services](https://www.alfresco.com/platform/process-services-bpm) (or simply Process Services) is an enterprise Business Process Management (BPM) solution targeted at business people and developers. At its core is a high performance open-source business process engine based on Activiti with the flexibility and scalability to handle a wide variety of critical processes. Alfresco Process Services provides a powerful suite of end user tools and integrates with a range of enterprise systems, including Alfresco Content Services, Box and Google Drive.


# Run the activiti-app container

Create the `activiti-app` image

 `export ACTIVITI_VERSION=1.9.0`

 `cd activiti-app/`

 `./build.sh`

You can specify the image tag either when running the build script or by modifying the `/etc/version` file

 `
 ./build.sh $ACTIVITI_VERSION
 `

To run the `activiti-app` container:

`docker run -p 8080:8080 alfresco/activiti-app:$ACTIVITI_VERSION`

The service will be available at the url

`http://localhost:8080/activiti-app`

# Run the activiti-admin container

Create the `activiti-admin` image

 `export ACTIVITI_VERSION=1.9.0`

`cd activiti-admin/`

`./build.sh`


You can specify the image tag either when running the build script or by modifying the `/etc/version` file

 `./build.sh $ACTIVITI_VERSION`

To run the `activiti-admin` container:

`docker run -p 8090:8080 process-services-admin:$ACTIVITI_VERSION`

(This command will expose your internal 8080 docker port to the 8090 external port)

The service will be available at the url

`http://localhost:8090/activiti-admin`

# Run more complex stacks

To run the APS in a more complex way, please refer to our https://github.com/Alfresco/aps-docker-library repository.