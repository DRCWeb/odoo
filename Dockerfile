FROM odoo:19

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

# Copiar e instalar requirements
COPY ./requirements.txt /requirements.txt

# Primero instalar numpy y paquetes base críticos para evitar conflictos de compilación
RUN pip3 install --no-cache-dir --prefer-binary \
    'numpy>=1.24.0,<2.0.0' \
    'setuptools>=60.0.0' \
    'Cython>=0.29.0'

# Instalar el resto de dependencias con flags optimizados para usar wheels precompiladas
RUN pip3 install --no-cache-dir \
    --prefer-binary \
    -r /requirements.txt

RUN rm /requirements.txt
