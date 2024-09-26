#!/bin/bash

REPO_URL = "https://github.com/drachens/ProyectoSyncBalanzasServer.git"
CLONE_DIR = "/home/hprt/Escritorio/serverHttp/"
PROGRAM_NAME = "serverHttp.py"
SETUP_FILENAME = "requirements.txt"
PROGRAM_DIR = "ProyectoSyncBalanzasServer"

sudo apt-get update

sudo apt-get install -y git nginx python3 python3-pip

if [-d "$CLONE_DIR $PROGRAM_DIR"]; then
    echo "La carpeta $PROGRAM_DIR ya existe. Eliminandola..."
    rm -rf "$CLONE_DIR $PROGRAM_DIR"
fi 

cd "$CLONE_DIR"

git clone -b server "$REPO_URL" 

cd "$PROGRAM_DIR" || {echo "No se pudo acceder al directorio."; exit 1; }

pip3 install -r "$SETUP_FILENAME"

nohup python3 "$PROGRAM_NAME" &

(crontab -l ; echo "@reboot cd $CLONE_DIR cd $PROGRAM_DIR && nohup python3 $PROGRAM_NAME &") | crontab -




