FROM odoo:19

USER root

# 1) Dependencias del sistema + herramientas para venv (PEP 668 friendly)
RUN apt-get update && apt-get install -y \
    python3-venv \
    python3-full \
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

# 2) Crear virtualenv dedicado (evita "externally-managed-environment")
RUN python3 -m venv /opt/venv

# 3) Forzar uso del venv para cualquier ejecución posterior (incluye Odoo si respeta PATH)
ENV PATH="/opt/venv/bin:$PATH"

# 4) Actualizar pip/setuptools/wheel dentro del venv
RUN pip install --upgrade pip setuptools wheel

# 5) (Opcional) limpiar paquete problemático si estuviera instalado en el venv
RUN pip uninstall -y pdfminer.six || true

# 6) Copiar e instalar requirements dentro del venv
COPY ./requirements.txt /tmp/requirements.txt

# Primero instalar bases críticas para minimizar compilaciones
RUN pip install --no-cache-dir --prefer-binary \
    "numpy>=1.24.0,<2.0.0" \
    "setuptools>=60.0.0" \
    "Cython>=0.29.0"

# Instalar el resto
RUN pip install --no-cache-dir --prefer-binary -r /tmp/requirements.txt \
    && rm -f /tmp/requirements.txt

# 7) Volver a usuario odoo por buenas prácticas (la imagen base lo suele tener)
USER odoo

