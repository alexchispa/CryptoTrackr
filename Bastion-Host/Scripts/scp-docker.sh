#!/bin/bash

# Variable para la carpeta remota
REMOTE_FOLDER="ubuntu@10.0.6.251:/tmp/BackUp_Volumenes"

# Clave privada para SSH
SSH_KEY="/home/ubuntu/Docker-Wordpress-Key.pem"

# Directorio local para descargar los archivos
LOCAL_DOWNLOAD_DIR="/home/ubuntu/descargas"

# Crear el directorio de descargas si no existe
mkdir -p $LOCAL_DOWNLOAD_DIR

# Descargar la carpeta remota
echo "Descargando archivos desde el servidor remoto..."
scp -i $SSH_KEY -r $REMOTE_FOLDER $LOCAL_DOWNLOAD_DIR

# Verificar si la descarga fue exitosa
if [ $? -eq 0 ]; then
    echo "Archivos descargados con éxito."
else
    echo "Error al descargar los archivos."
    exit 1
fi
