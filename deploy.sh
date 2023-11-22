#!/bin/bash

# Função para verificar a disponibilidade de uma porta
check_port() {
  local host=$1
  local port=$2
  while ! nc -z "$host" "$port"; do
    echo "A porta $port não está acessível em $host. Aguardando..."
    sleep 5
  done
  echo "A porta $port está acessível em $host. Continuando..."
}

# Configurar o contexto do Kubernetes automaticamente
echo "Configurando o contexto do Kubernetes..."
current_context=$(kubectl config current-context)
if [ -z "$current_context" ]; then
  echo "Erro: O contexto do Kubernetes não está configurado. Configure o contexto usando 'kubectl config use-context CONTEXT_NAME'."
  exit 1
else
  echo "Contexto do Kubernetes configurado para: $current_context"
fi

# Aplicar os manifestos Kubernetes antes de executar Docker e Java
echo "Aplicando manifestos Kubernetes..." 
chmod +x mysql-deployment.yaml && chmod +x java-deployment.yaml
kubectl apply -f mysql-deployment.yaml
kubectl apply -f java-deployment.yaml

# Aguardar a implantação completa (pode variar dependendo do ambiente)
echo "Aguardando a implantação completa..."
sleep 30

# Exibir informações sobre os serviços e pods antes de executar Docker e Java
echo "Informações sobre serviços (antes):"
kubectl get services

echo "Informações sobre pods (antes):"
kubectl get pods

# Executar o script Docker
echo "Executando o script Docker..."
chmod +x ./docker.sh
./docker.sh

# Aguardar alguns segundos para garantir que o MySQL esteja pronto
echo "Aguardando a inicialização do MySQL..."
sleep 15

# Exibir informações sobre os serviços e pods após a execução de Docker e Java
echo "Informações sobre serviços (depois):"
kubectl get services

echo "Informações sobre pods (depois):"
kubectl get pods

# Verificar a acessibilidade da porta 8080 antes de executar o script Java
echo "Verificando a acessibilidade da porta 8080..."
check_port "localhost" "8080"

# Executar o script Java
echo "Executando o script Java..."
chmod +x ./java.sh
./java.sh
