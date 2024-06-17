#!/bin/bash

# Directorio donde se guardarán los archivos comprimidos
COMPRESSED_DIR="/etc/bu"

# Crear el directorio si no existe
mkdir -p $COMPRESSED_DIR

# Archivos a comprimir
FILE1="/var/lib/docker/volumes/cryptotrackr_domain/_data"
FILE2="/var/lib/docker/volumes/cryptotrackr_wordpress/_data"

# Comprimir los archivos en un archivo tar
tar -czf $COMPRESSED_DIR/cryptotrackr_domain.tar.gz $FILE1
tar -czf $COMPRESSED_DIR/cryptotrackr_wordpress.tar.gz $FILE2

# Verificar si la compresión fue exitosa
if [ $? -eq 0 ]; then
    echo "Archivos comprimidos con éxito."
else
    echo "Error al comprimir los archivos."
    exit 1
fi
