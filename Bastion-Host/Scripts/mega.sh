#!/bin/bash

# Ruta completa al comando megaput
MEGA_CMD="/snap/bin/mega-cmd"

# Variables de Mega
MEGA_USERNAME="amartinezc24@educantabria.es"
MEGA_PASSWORD="Dinosaurio10"
MEGA_REMOTE_DIR="/backups/archivo.txt"

# Archivo local a subir
LOCAL_FILE="/home/ubuntu/archivo.txt"

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
