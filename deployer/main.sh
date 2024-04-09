#!/bin/bash
#
GIT_REPO=$1
IMAGE_NAME=$2
DOWNLOAD_PATH=$3

git clone $GIT_REPO $DOWNLOAD_PATH
docker build -t $IMAGE_NAME:heron $DOWNLOAD_PATH
nohup docker run -p 8080:80 $IMAGE_NAME:heron & #run detached process 

cd $DOWNLOAD_PATH
while true; do 
  sleep 10
  echo "pulling!"
  pull="$(git pull)"
  pwd
  echo $pull
  if [[ "$pull" != 'Already up to date.' ]]; then
    echo "change detected"
    docker stop $(docker ps -q)
    docker build -t $IMAGE_NAME:heron .
    nohup docker run -p 8080:80 $IMAGE_NAME:heron & #run detached process 
  else
    echo "no changes detected"
  fi
done