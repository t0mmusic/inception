#!/bin/bash

base_dir="/home/$USER/data"
wordpress_dir="$base_dir/wordpress"
mysql_dir="$base_dir/mysql"

if [ ! -d "$base_dir" ]; then
    mkdir "$base_dir"
fi

if [ ! -d "$wordpress_dir" ]; then
    mkdir "$wordpress_dir"
fi

if [ ! -d "$mysql_dir" ]; then
    mkdir "$mysql_dir"
fi