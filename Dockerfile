FROM odoo:18

USER root

# Instalar dependencias del sistema necesarias para compilar paquetes
RUN apt-get update && apt-get install -y \
    gcc \
    g++ \
    python3-dev \
    build-essential \
    libcurl4-openssl-dev \
    libssl-dev \
    libldap2-dev \
    libsasl2-dev \
    libxml2-dev \
    libxslt1-dev \
    libffi-dev \
    && rm -rf /var/lib/apt/lists/*

# Actualizar pip y setuptools
RUN pip3 install --upgrade pip setuptools wheel

# Desinstalar paquetes problemáticos con versiones inválidas de la imagen base
RUN pip3 uninstall -y pdfminer.six || true