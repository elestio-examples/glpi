#set env vars
set -o allexport; source .env; set +o allexport;

mkdir -p ./storage/var/www/html/glpi/
chown -R 33:33 ./storage/var/www/html/glpi/
