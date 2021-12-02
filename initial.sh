#!/bin/bash

#[PRE-REQUISITOS: git, docker, docker-compose, curl, wget]
apt-get update >> /dev/null && apt-get -y install htop curl wget >> /dev/null

mkdir -p /data/big-data-storage

#Verificando se o docker e docker-compose esta instalado no sistema!"

if [[ $(which docker) && $(docker --version) ]]; then
    
    echo "Docker Instalado No Sistema!"
    sleep 2
  else
  	
    echo "Docker Nao Instalado No Sistema!"
    sleep 2 
    
    echo "Instalado Docker no Sistema!"
    curl -fsSL https://get.docker.com -o get-docker.sh
    chmod +x get-docker.sh && sh get-docker.sh
fi

if [[ $(which docker-compose) && $(docker-compose --version) ]]; then
    
    echo "Docker-Compose Instalado No Sistema!"
    sleep 2
  else
  	
    echo "Docker-Compose Nao Instalado No Sistema!"
    sleep 2 
    
    echo "Instalado Docker-Compose no Sistema!"
    curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
    chmod +x /usr/local/bin/docker-compose
    ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose
fi

if [[ $(which git) ]]; then
    
    echo "Git instalado no sistema!"
    sleep 2
  else
  	
    echo "Git Nao Instalado No Sistema!"
    sleep 2 
    
    apt-get update && apt-get -y install git
fi

if [[ $(docker network  ls | grep "hadoop") ]]; then
    
    echo "Rede Hadoop ja Criada!"

else
     
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
    
    echo "Imagem ja construida!"
    cd data
  else
  	
    echo "Imagem nao construida no Sistema!"
    cd data/Hadoop && docker build -t hadoop-image .
    cd ..


fi

if [[ $(docker images | grep "flume-image") ]]; then
    
    echo "Imagem ja construida!"
  else
  	
    echo "Imagem nao construida no Sistema!"
    pwd
    cd Flume/ && docker build -t flume-image .
    cd ..
fi

if [[ $(docker images | grep "sqoop-image") ]]; then
    
    echo "Imagem ja construida!"
  else
  	
    echo "Imagem nao construida no Sistema!"
    cd Sqoop/ && docker build -t sqoop-image .
    cd ..
    

fi

if [[ $(docker images | grep "hive-image") ]]; then
    
    echo "Imagem ja construida!"
  else
  	
    echo "Imagem nao construida no Sistema!"
    cd Hive/ && docker build -t hive-image .
    cd ..

fi

if [[ $(docker images | grep "postgres:11.5") ]]; then
    
    echo "Imagem ja construida!"
  else
  	
    echo "Imagem nao construida no Sistema!"
    docker pull postgres:11.5
fi

if [[ $(docker images | grep "portainer/portainer-ce") ]]; then
    
    echo "Imagem ja baixada!"
  else
  	
    echo "Imagem nao baixada no Sistema!"
    docker pull portainer/portainer-ce:latest
fi

docker-compose up -d
docker-compose -f Portainer/docker-compose.yml up -d