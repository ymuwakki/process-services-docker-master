#!/bin/bash

scriptname=../$0
passed_version=$1

# Globals
declare version
declare scriptdir

# Read in current version from etc/version - this is used as
# the default
set_version () {
    scriptdir=$(dirname ${scriptname})

    local current_version_file=${scriptdir}/etc/version
    local current_version=$(cat ${current_version_file})

    # If a version was given on the command line, use that
    version=${passed_version:-${current_version}}
}

# Check docker is installed
# Not totally necessary. Neither is the
check_for_docker () {
    local docker_test=''

    if [[ -n $BASH_VERSINFO && ( $BASH_VERSINFO -ge 4 ) ]]
    then
        docker_test='docker &>> /dev/null'
    else
        # bash 3.x and below. Thank you Apple.
        docker_test='docker >> /dev/null 2>&1'
    fi

    eval ${docker_test}
    local retval=$?
    if [ ${retval} -ne 0 ]
    then
        echo 'No docker found'
        exit ${retval}
    fi
}

# Check for docker existing.

check_for_docker
set_version
echo $version

echo "Downloading Activiti Admin war file..."
mvn -DACTIVITI_VERSION=${version} clean package

docker build --squash -f ./Dockerfile --build-arg ACTIVITI_VERSION=${version} -t process-services-admin:${version} ${scriptdir}
