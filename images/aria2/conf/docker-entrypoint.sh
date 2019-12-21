#!/usr/bin/env sh

COPY docker-entrypoint.sh /usr/local/bin/
ENTRYPOINT ["docker-entrypoint.sh"]

tail -f /var/log/auth.log