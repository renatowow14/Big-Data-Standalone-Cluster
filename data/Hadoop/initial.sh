#!/bin/bash

#[PRE-REQUISITOS: git, docker, docker-compose, curl, wget]

#"Verificando se o docker esta instalado no sistema!"

apt-get update && apt-get -y install htop curl wget >> /dev/null

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

cd /root
git clone https://github.com/renatowow14/Hadoop-Docker-Cluster.git

if [ -d "/root/Hadoop-Docker-Cluster/" ] 
then
    echo "Directory /path/to/dir exists, GIT-PULL" 
    cd /root/Hadoop-Docker-Cluster/
    git pull

else
    echo "Error: Directory /path/to/dir does not exists, GIT-CLONE"
    cd /root
    git clone https://github.com/renatowow14/Hadoop-Docker-Cluster.git
fi

if [[ $(docker images | grep "hadoop-image") ]]; then
    clear
    echo "Imagem ja construida!"
    sleep 2
    bash ./start-container.sh
  else
  	clear
    echo "Imagem nao construida no Sistema!"
    sleep 2 
    clear
    git clone https://github.com/renatowow14/Hadoop-Docker-Cluster.git
	cd Hadoop-Docker-Cluster
	DOCKER_BUILDKIT=1 docker build -t hadoop-image .
	docker network create --driver=bridge hadoop
    docker-compose up -d 
    bash ./start-cluster.sh

fi
