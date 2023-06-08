#     FROM: Specifies the base image for your Docker image.
#     RUN: Executes a command inside the container while building the image.
#     COPY: Copies files and directories from the host machine to the container.
#     ADD: Similar to COPY, but also supports downloading files from URLs and extracting tar archives.
#     WORKDIR: Sets the working directory for subsequent instructions.
#     ENV: Sets environment variables inside the container.
#     EXPOSE: Informs Docker that the container listens on specific network ports at runtime.
#     CMD: Provides the default command to run when the container starts.
#     ENTRYPOINT: Configures the container to run as an executable.
#     VOLUME: Creates a mount point and associates it with a directory or a data volume container.
#     ARG: Defines variables that users can pass at build-time to the builder with the build command.
#     LABEL: Adds metadata to an image in the form of key-value pairs.
#     USER: Sets the username or UID to use when running the image.
#     ONBUILD: Triggers a command to be executed when the image is used as a base for another build.
#     STOPSIGNAL: Sets the system call signal that will be sent to the container to exit.

FROM	debian:buster

RUN		apt-get update
RUN		apt-get install -y nginx \
                openssl

RUN mkdir /etc/nginx/ssl
RUN openssl req -newkey rsa:4096 -x509 -sha256 -days 365 -nodes \
       -out /etc/nginx/ssl/jbrown.crt \
       -keyout /etc/nginx/ssl/jbrown.key \
       -subj "/C=FR/ST=Paris/L=Paris/O=42 School/OU=jbrown/CN=jbrown/"

COPY ./conf/nginx.conf /etc/nginx/conf.d

RUN mkdir -p /run/nginx

EXPOSE	443

CMD ["nginx", "-g", "daemon off;"]