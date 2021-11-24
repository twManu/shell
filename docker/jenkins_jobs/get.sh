#!/bin/bash

tasks=(
	"check_space"
	"q8_buildroot"
	"q8_client"
	"q8_pipe"
	"q8_server"
)


for ((i=0; i<${#tasks[@]}; i++)); do
	echo Getting task ${tasks[i]}
	java -jar jenkins-cli.jar -auth manu:manu -s http://localhost:8080 get-job ${tasks[i]} > ${tasks[i]}.xml
done
