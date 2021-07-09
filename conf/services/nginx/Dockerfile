ARG NGINX_VERSION
FROM ${NGINX_VERSION}

ARG TZ
ARG NGINX_VERSION
ARG CONTAINER_PACKAGE_URL
ARG NGINX_INSTALL_APPS


COPY ./initsh /usr/local/bin/
RUN chmod 777 /usr/local/bin/initsh


ENV INSTALL_APPS=",${NGINX_INSTALL_APPS},"

RUN if [ "${CONTAINER_PACKAGE_URL}" != "" ]; then \
        sed -i "s/dl-cdn.alpinelinux.org/${CONTAINER_PACKAGE_URL}/g" /etc/apk/repositories; \
    fi

RUN if [ -z "${INSTALL_APPS##*,certbot,*}" ]; then \
        echo "---------- Install certbot ----------"; \
        apk add --no-cache certbot; \
    fi

WORKDIR /www
