FROM odoo:19

USER root

# Eliminar addons de la imagen base para usar los montados desde el repositorio
RUN rm -rf /usr/lib/python3/dist-packages/odoo/addons/*

RUN apt-get update && apt-get install -y \
    libldap2-dev \
    libsasl2-dev \
    libssl-dev \
    libxml2-dev \
    libxslt1-dev \
    libffi-dev \
    && rm -rf /var/lib/apt/lists/*

USER odoo
	

