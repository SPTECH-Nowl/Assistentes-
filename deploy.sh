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
  kubeconfig_path=$(kubectl config view --minify -o jsonpath='{.contexts[0].context.cluster.kubeconfig}')
  if [ -n "$kubeconfig_path" ]; then
    current_context=$(kubectl config view --kubeconfig="$kubeconfig_path" --minify -o jsonpath='{.contexts[0].name}')
    kubectl config use-context "$current_context" --kubeconfig="$kubeconfig_path"
    echo "Contexto do Kubernetes configurado para: $current_context"
  else
    echo "Erro: Não foi possível determinar o contexto do Kubernetes. Verifique sua configuração."
    exit 1
  fi
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
