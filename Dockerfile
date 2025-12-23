FROM odoo:19

LABEL org.opencontainers.image.title="odoo-v19-prod"
LABEL org.opencontainers.image.description="Odoo 19 production image with system deps"
LABEL org.opencontainers.image.version="19"

USER root

RUN apt-get update && apt-get install -y \
    libldap2-dev \
    libsasl2-dev \
    libssl-dev \
    libxml2-dev \
    libxslt1-dev \
    libffi-dev \
    && rm -rf /var/lib/apt/lists/*

USER odoo

