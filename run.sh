#!/usr/bin/env bash

java -DServerPort=${PORT1} -DServiceUrl=http://userservice:9090 -jar /app.jar  &
java -DServerPort=${PORT2} -DServiceUrl=http://userservice:9090 -jar /app.jar