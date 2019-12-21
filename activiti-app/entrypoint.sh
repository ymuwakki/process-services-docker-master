#!/bin/sh

$HOME/set-activiti-config.sh
$HOME/set-activiti-identity-config.sh
$CATALINA_HOME/bin/catalina.sh run
