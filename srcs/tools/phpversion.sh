#!/bin/bash

url="https://www.php.net/releases/?json"
data=$(curl -s "$url")

if [ -z "$data" ]; then
	return 1
fi

version_beginning=${data%%"php-"*}
version_end=${data%%".tar.gz"*}

index_beginning=$(( ${#version_beginning} ))
index_end=$(( ${#version_end} ))

initally="$(($index_beginning+4))"
finally="$(($index_end-$initally))"

php=${data:initally:finally}

export PHP_VERSION=$php

if ! grep -Fxq "PHP_VERSION=${PHP_VERSION}" "./srcs/.env"; then
	echo -e "\nPHP_VERSION=${PHP_VERSION}" >> ./srcs/.env
fi