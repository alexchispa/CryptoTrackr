#!/bin/bash

######################################################  MYSQL BACKUP
# Variables de la base de datos remota
REMOTE_DB_HOST="10.0.7.25"
REMOTE_DB_USER="admin"
REMOTE_DB_PASS="admin123"
REMOTE_DB_NAME="CryptoTrackrDB"

# Directorio donde se guardarán las copias de seguridad
BACKUP_DIR="/home/ubuntu/backups/mysql"

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


######################################################  WORDPRESS BACKUP

# Variable para la carpeta remota
REMOTE_FOLDER="ubuntu@10.0.6.251:/etc/bu/*"

# Clave privada para SSH
SSH_KEY="/home/ubuntu/Docker-Wordpress-Key.pem"

# Directorio local para descargar los archivos
LOCAL_DOWNLOAD_DIR="/home/ubuntu/backups/wordpress"

# Crear el directorio de descargas si no existe
mkdir -p $LOCAL_DOWNLOAD_DIR

# Descargar la carpeta remota
echo "Descargando archivos desde el servidor remoto..."
scp -i $SSH_KEY -r $REMOTE_FOLDER $LOCAL_DOWNLOAD_DIR >/dev/null 2>&1

# Verificar si la descarga fue exitosa
if [ $? -eq 0 ]; then
    echo "Archivos descargados con éxito."
else
    echo "Error al descargar los archivos."
    exit 1
fi


######################################################  UPLOAD TO MEGA

# Ruta completa al comando megaput
MEGA_CMD="/snap/bin/mega-cmd"

# Variables de Mega
MEGA_USERNAME="amartinezc24@educantabria.es"
MEGA_PASSWORD="Dinosaurio10"
MEGA_REMOTE_DIR="/Security"

# Archivo local a subir
LOCAL_FILE="/home/ubuntu/backups"

# Crear un archivo temporal para almacenar los comandos
TMP_FILE="/tmp/mega_commands.txt"

# Escribir los comandos en el archivo temporal
echo "login $MEGA_USERNAME $MEGA_PASSWORD" > $TMP_FILE
echo "put $LOCAL_FILE $MEGA_REMOTE_DIR" >> $TMP_FILE
echo "exit" >> $TMP_FILE

# Ejecutar los comandos en mega-cmd
$MEGA_CMD < $TMP_FILE

# Eliminar el archivo temporal
rm $TMP_FILE

# Verificar si la subida fue exitosa
if [ $? -eq 0 ]; then
    echo "Archivo subido a Mega con éxito."
else
    echo "Error al subir el archivo a Mega."
    exit 1
fi
