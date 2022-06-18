#!/bin/bash

FILENAME="users.txt"
RE='^[0-9]+$'
while read -r line || [ -n "$line" ]; do
  ID=$(echo "$line" | awk '{print $NF}')
  EMAIL=$(echo "$line" | grep -E -o "[a-zA-Z0-9.-]+@[a-zA-Z0-9.-]+\.[a-zA-Z0-9.-]{2,24}")
  if [[ "$ID" =~ $RE && "$EMAIL" ]]; then
    if [ "$(expr "$ID" % 2)" == 0 ]; then
        echo "the $ID of $EMAIL is even"
        else
          echo "the $ID of $EMAIL is odd"
    fi
  fi
done <$FILENAME