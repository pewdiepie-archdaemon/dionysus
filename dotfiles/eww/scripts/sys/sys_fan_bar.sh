#!/bin/bash

usage=$1  # percent or normalized value
full="█"
empty="░"
blocks=10
filled=$(( usage * blocks / 100 ))
bar=""

for ((i=0; i<blocks; i++)); do
  if [ $i -lt $filled ]; then
    bar+="$full"
  else
    bar+="$empty"
  fi
done

echo "$bar"
