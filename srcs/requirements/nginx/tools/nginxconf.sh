#!/bin/bash

if [[ ! -f nginx.conf ]]; then
cat > nginx.conf << EOL
server {
	listen 443 ssl;
	listen [::]:443 ssl;

	## Website name SUBDOMAIN.DOMAIN.TLD
	server_name $USER.42.fr;

	ssl_certificate		/etc/nginx/ssl/$USER.crt;
	ssl_certificate_key	/etc/nginx/ssl/$USER.key;

	ssl_protocols		TLSv1.2 TLSv1.3;

	## Logs
	access_log /var/log/nginx/$USER.access.log;
	error_log /var/log/nginx/$USER.error.log;

	## Path of site files with entry file
	root /var/www/html;
	index index.php;

	location / {
		try_files \$uri \$uri/ /index.php\$is_args\$args;
	}

	location ~ \.php$ {
		include fastcgi_params; # /ect/nginx/fastcgi_params
		fastcgi_intercept_errors on;
		fastcgi_split_path_info ^(.+\.php)(/.+)$;
		fastcgi_pass wordpress:9000;
		fastcgi_index index.php;
		fastcgi_param SCRIPT_FILENAME \$document_root\$fastcgi_script_name;
		fastcgi_param SCRIPT_NAME \$fastcgi_script_name;
	}

    # Adminer configuration
    location /adminer {
        index index.php;
        try_files \$uri \$uri/ /index.php?\$args;
    }

    location ~ ^/adminer/.*\.php$ {
        include fastcgi_params;
        fastcgi_pass adminer:9001;
        fastcgi_param SCRIPT_FILENAME \$request_filename;
    }
}

EOL
chmod +x nginx.conf
fi

exec nginx -g 'daemon off;'
