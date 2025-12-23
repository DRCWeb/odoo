FROM odoo:19

USER root

# Solo dependencias del sistema que realmente necesites para tus módulos.
# Si no tienes dependencias extra, puedes incluso borrar este bloque completo.
RUN apt-get update && apt-get install -y \
    libldap2-dev \
    libsasl2-dev \
    libssl-dev \
    libxml2-dev \
    libxslt1-dev \
    libffi-dev \
    && rm -rf /var/lib/apt/lists/*

USER odoo

