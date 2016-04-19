#!/bin/bash

my_array=(abc def ghi)

for ((i=0; i<${#my_array[@]}; i++ )); do echo ${my_array[$i]}; done
echo ${my_array[*]}
