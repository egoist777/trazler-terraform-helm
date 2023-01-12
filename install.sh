#!/bin/bash

echo Pass a terraform workspace name...
read workspace
echo Pass a release name...
read release
echo Pass a tag...
read tag
export TF_VAR_docker_tag=$tag
export TF_VAR_release_name=$release

eval $(minikube -p minikube docker-env)

cd nginx-trazler
docker build -t nginx:$tag  . && cd ../terraform 
terraform init 
terraform workspace new $workspace || terraform workspace select $workspace
terraform apply -auto-approve && sleep 8

if grep -R "127.0.0.1  trazler.info" "/etc/hosts"
then 
  echo "Record exists!"
else
  echo "Adding record..."
  echo "127.0.0.1  trazler.info" >> /etc/hosts
fi

minikube service $release-$workspace-trazler-service &

