#!/bin/bash

# Gets the tag name of the latest debian image on dockerhub. Unfortunately only the latest unstable release
response=$(curl -s "https://hub.docker.com/v2/repositories/library/debian/tags/?page_size=1")
latest_tag=$(echo "$response" | jq -r '.results[0].name')
echo "Latest Debian image tag: $latest_tag"