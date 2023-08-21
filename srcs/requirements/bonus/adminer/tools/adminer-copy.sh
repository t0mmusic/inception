#!/bin/bash

mkdir /adminer/adminer
cp /index.php /adminer/adminer/index.php

exec php -S 0.0.0.0:9001 -t /adminer/adminer