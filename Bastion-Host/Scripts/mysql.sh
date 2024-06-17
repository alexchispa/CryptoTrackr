#!/bin/bash

# Variables de la base de datos remota
REMOTE_DB_HOST="10.0.7.25"
REMOTE_DB_USER="admin"
REMOTE_DB_PASS="admin123"
REMOTE_DB_NAME="CryptoTrackrDB"

# Directorio donde se guardarán las copias de seguridad
BACKUP_DIR="/home/ubuntu/backups"

# Crear el directorio de copias de seguridad si no existe
mkdir -p $BACKUP_DIR

# Nombre del archivo de copia de seguridad
BACKUP_FILE="$BACKUP_DIR/Database_Backup_$(date +\%F).sql"

# Realizar la copia de seguridad remota
echo "Realizando copia de seguridad de la base de datos remota..."
mysqldump -h $REMOTE_DB_HOST -u $REMOTE_DB_USER -p$REMOTE_DB_PASS $REMOTE_DB_NAME > $BACKUP_FILE 2>/dev/null

# Verificar si la copia de seguridad remota fue exitosa
if [ $? -eq 0 ]; then
    echo "Copia de seguridad de la base de datos remota realizada con éxito."
else
    echo "Error al realizar la copia de seguridad de la base de datos remota."
    exit 1
fi
