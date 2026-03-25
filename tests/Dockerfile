FROM glpi/glpi:latest

USER root

WORKDIR /opt/elestio

RUN apt update && apt install ncdu -y

COPY ./elestio /opt/elestio

USER www-data

WORKDIR /var/www/glpi
