#!/bin/sh
set -e

# Substitute the JWT secret from the environment variable before the
# run-document-server.sh script moves local.dist.json (mounted files can't be moved)
sed "s/ONLYOFFICE_JWT_SECRET_PLACEHOLDER/${ONLYOFFICE_JWT_SECRET:-CHANGE_ME_ONLYOFFICE_JWT_SECRET}/g" \
    /etc/onlyoffice/documentserver/local.dist.json \
    > /etc/onlyoffice/documentserver/local.json

if [ -f /var/www/onlyoffice/Data/license.lic ]; then
  chmod 644 /var/www/onlyoffice/Data/license.lic || true
fi

/app/ds/run-document-server.sh
