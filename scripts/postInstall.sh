#set env vars
set -o allexport; source .env; set +o allexport;

#wait until the server is ready
echo "Waiting for software to be ready ..."
sleep 60s;

# Wait for GLPI installation to complete
echo "Waiting for GLPI installation to complete..."
until docker-compose logs glpi 2>&1 | grep -q "GLPI installation completed successfully"; do
    echo "Still installing..."
    sleep 10
done

echo "GLPI installed. Changing admin credentials..."

# Generate bcrypt hash for password
HASH=$(docker-compose exec -T glpi php -r "echo password_hash('${ADMIN_PASSWORD}', PASSWORD_BCRYPT);")

# Update password via SQL
docker-compose exec -T mysql mysql -u${MYSQL_USER} -p${MYSQL_PASSWORD} ${MYSQL_DATABASE} -e "UPDATE glpi_users SET password='${HASH}' WHERE name='glpi';" 2>/dev/null

# Add email for glpi user
docker-compose exec -T mysql mysql -u${MYSQL_USER} -p${MYSQL_PASSWORD} ${MYSQL_DATABASE} -e "INSERT INTO glpi_useremails (users_id, is_default, is_dynamic, email) SELECT id, 1, 0, '${ADMIN_EMAIL}' FROM glpi_users WHERE name='glpi';" 2>/dev/null
