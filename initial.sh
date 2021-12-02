#!/bin/bash

#[PRE-REQUISITOS: git, docker, docker-compose, curl, wget]
apt-get update && apt-get -y install htop curl wget >> /dev/null

#Verificando se o docker e docker-compose esta instalado no sistema!"

if [[ $(which docker) && $(docker --version) ]]; then
    clear
    echo "Docker Instalado No Sistema!"
    sleep 2
  else
  	clear
    echo "Docker Nao Instalado No Sistema!"
    sleep 2 
    clear
    echo "Instalado Docker no Sistema!"
    curl -fsSL https://get.docker.com -o get-docker.sh
    chmod +x get-docker.sh && sh get-docker.sh
fi

if [[ $(which docker-compose) && $(docker-compose --version) ]]; then
    clear
    echo "Docker-Compose Instalado No Sistema!"
    sleep 2
  else
  	clear
    echo "Docker-Compose Nao Instalado No Sistema!"
    sleep 2 
    clear
    echo "Instalado Docker-Compose no Sistema!"
    curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
    chmod +x /usr/local/bin/docker-compose
    ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose
fi

if [[ $(which git) ]]; then
    clear
    echo "Git instalado no sistema!"
    sleep 2
  else
  	clear
    echo "Git Nao Instalado No Sistema!"
    sleep 2 
    clear
    apt-get update && apt-get -y install git
fi

if [ -d "data/Big-Data-Standalone-Cluster" ] 
then
    echo "Directory /path/to/dir exists, GIT-PULL" 
    cd data/Big-Data-Standalone-Cluster
    git pull

else
    echo "Error: Directory /path/to/dir does not exists, GIT-CLONE"
    cd data
    git clone https://github.com/renatowow14/Big-Data-Standalone-Cluster.git
fi


if [[ $(docker network  ls | grep "hadoop") ]]; then
    clear
    echo "Rede Hadoop ja Criada!"

else
     clear
     echo "Rede Hadoop Nao Criada!"
     echo "Criando!"
     docker network create \
    --driver=bridge \
    --subnet=172.25.0.0/16 \
    --ip-range=172.25.0.0/24 \
    --gateway=172.25.0.254 \
    hadoop
fi

if [[ $(docker images | grep "hadoop-image") ]]; then
    clear
    echo "Imagem ja construida!"
  else
  	clear
    echo "Imagem nao construida no Sistema!"
    cd data/Hadoop && docker build -t hadoop-image .


fi

if [[ $(docker images | grep "flume-image") ]]; then
    clear
    echo "Imagem ja construida!"
  else
  	clear
    echo "Imagem nao construida no Sistema!"
    cd data/Flume && docker build -t flume-image .
    

fi

if [[ $(docker images | grep "sqoop-image") ]]; then
    clear
    echo "Imagem ja construida!"
  else
  	clear
    echo "Imagem nao construida no Sistema!"
    cd data/Sqoop && docker build -t sqoop-image .
    

fi

if [[ $(docker images | grep "hive-image") ]]; then
    clear
    echo "Imagem ja construida!"
  else
  	clear
    echo "Imagem nao construida no Sistema!"
    cd data/Hive && docker build -t hive-image .

fi

if [[ $(docker images | grep "postgres:11.5") ]]; then
    clear
    echo "Imagem ja construida!"
  else
  	clear
    echo "Imagem nao construida no Sistema!"
    docker pull postgres:11.5
fi

if [[ $(docker images | grep "portainer/portainer-ce") ]]; then
    clear
    echo "Imagem ja construida!"
  else
  	clear
    echo "Imagem nao construida no Sistema!"
    docker-compose -f data/Portainer/docker-compose.yml up -d
fi

cd data/data/Portainer
docker-compose up -d




