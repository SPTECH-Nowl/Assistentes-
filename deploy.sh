#!/bin/bash

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

# Aplicar os manifestos Kubernetes
echo "Aplicando manifestos Kubernetes..."
kubectl apply -f mysql-deployment.yaml
kubectl apply -f java-deployment.yaml

# Aguardar a implantação completa (pode variar dependendo do ambiente)
echo "Aguardando a implantação completa..."
sleep 30

# Exibir informações sobre os serviços e pods
echo "Informações sobre serviços:"
kubectl get services

echo "Informações sobre pods:"
kubectl get pods
