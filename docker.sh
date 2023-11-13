#!/bin/sh

# Mensagem informativa sobre a instalação do Docker
echo "Instalando o Docker..."
sudo apt install docker.io
echo "Docker instalado com sucesso!"

# Iniciar o serviço do Docker
echo "Iniciando o serviço do Docker..."
sudo systemctl start docker
sudo systemctl enable docker

# Baixar a imagem do MySQL 5.7
echo "Baixando a imagem do MySQL 5.7..."
sudo docker pull mysql:5.7
echo "Imagem do MySQL 5.7 baixada com sucesso!"

# Criar e executar o container MySQL
echo "Criando e executando o container MySQL..."
sudo docker run -d -p 3306:3306 --name magister -e "MYSQL_ROOT_PASSWORD=aluno" mysql:5.7
echo "Container MySQL criado e em execução!"

# Executar o script SQL dentro do container MySQL
echo "Executando o script SQL dentro do container MySQL..."
sleep 15
sudo docker exec -i magister mysql -u root -paluno < /home/ubuntu/Assistentes-app/script.sql

echo "Script SQL executado com sucesso!"

# Dar permissão de execução ao arquivo java.sh
echo "Dando permissão de execução ao arquivo java.sh..."
chmod +x java.sh
echo "Permissão concedida com sucesso!"

# Executar o arquivo java.sh
echo "Executando o arquivo java.sh..."
./java.sh
echo "Arquivo java.sh executado com sucesso!"
