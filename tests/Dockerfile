FROM glpi/glpi:latest

WORKDIR /opt/elestio

RUN apt update && apt install ncdu

COPY ./elestio /opt/elestio

WORKDIR /var/www/glpi