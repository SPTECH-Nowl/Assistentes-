#!/bin/bash


# Instalando kubcetl
echo "Instalando kubectl ..."

sudo apt-get update && sudo apt-get install -y kubectl

sleep 15

# Aplicar os manifestos Kubernetes antes de executar Docker e Java
echo "Aplicando manifestos Kubernetes..."
kubectl apply -f mysql-deployment.yaml
kubectl apply -f java-deployment.yaml


# Aguardar a implantação completa (pode variar dependendo do ambiente)
echo "Aguardando a implantação completa..."
sleep 15

# Exibir informações sobre os serviços e pods antes de executar Docker e Java
echo "Informações sobre serviços (antes):"
sleep 15
kubectl get services

echo "Informações sobre pods (antes):"
sleep 15
kubectl get pods

# Executar o script Docker
echo "Executando o script Docker..."
chmod +x ./docker.sh
./docker.sh

# Aguardar alguns segundos para garantir que o MySQL esteja pronto
sleep 15

# Executar o script Java
echo "Executando o script Java..."
chmod +x ./java.sh
./java.sh

# Aguardar mais alguns segundos para garantir que o Java esteja pronto

# Exibir informações sobre os serviços e pods após a execução de Docker e Java
echo "Informações sobre serviços (depois):"
kubectl get services

echo "Informações sobre pods (depois):"
kubectl get pods
