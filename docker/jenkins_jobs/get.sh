#!/bin/bash
# run after
# docker exec -it mj /bin/bash

tasks=(
	"check_space"
	"clean_yyyymm"
	"copy_to_release"
	"edge_be"
	"edge_branch"
	"edge_fe"
	"edge_pipe"
	"edge_v20"
	"q8_buildroot"
	"q8_branch"
	"q8_client"
	"q8_pipe"
	"q8_server"
	"q8_webui"
	"q8_v01"
	"release_to_version"
)

#replaced by edge_pipe "edge_sys"
#replaced by edge_pipe "edge_system"

#edge_sys and edge_system deprecate

for ((i=0; i<${#tasks[@]}; i++)); do
	echo Getting task ${tasks[i]}
	java -jar jenkins-cli.jar -auth manu:manu -s http://localhost:8080 get-job ${tasks[i]} > ${tasks[i]}.xml
done
