#!/bin/sh

sudo apt update && sudo apt upgrade
# Instalação do Docker
sudo apt-get update
sudo apt-get install docker.io -y

# Iniciar o serviço do Docker
sudo systemctl start docker
sudo systemctl enable docker

# Verificar se o container MySQL já existe
if ! docker ps -a --format '{{.Names}}' | grep -q "magister"; then
    # Criar e executar o container MySQL
   sudo docker run -d --name magister -e MYSQL_ROOT_PASSWORD=aluno -p 3306:3306 mysql:latest

    # Aguardar alguns segundos para o container ser criado e iniciado
    

    # Copiar o script SQL para dentro do container
sudo docker exec -it magister mysql -u root -paluno < /home/ubuntu/Assistentes-app/script.sql
    echo "Tabelas criadas com sucesso!"
else
    echo "O container MySQL já existe. Ignorando a criação de tabelas."
fi

echo "Agora iremos verificar se você já possui o Java instalado, aguarde um instante..."
sleep 5

if ! command -v java &> /dev/null; then
    echo "Você ainda não possui o Java instalado."
    echo "Confirme se deseja instalar o Java (S/N)?"
    read inst
    if [ "$inst" == "S" ]; then
        echo "Ok! Você escolheu instalar o Java."
        echo "Adicionando o repositório..."
        sleep 7
        sudo add-apt-repository ppa:linuxuprising/java -y
        clear
        echo "Atualizando os pacotes... Quase acabando."
        sleep 7
        sudo apt update -y

        # Instalação do Java
        if [ $VERSAO -eq 17 ]; then
            echo "Preparando para instalar a versão 17 do Java. Lembre-se de confirmar a instalação quando necessário!"
            sudo apt-get install openjdk-17-jdk -y
            clear
            echo "Java instalado com sucesso!"
            echo "Vamos atualizar os pacotes..."
            sudo apt update && sudo apt upgrade -y
        fi
    else
        echo "Você optou por não instalar o Java no momento."
    fi
else
    echo "Você já possui o Java instalado!"
fi

# Navegar para o diretório Desktop (ajuste o caminho conforme necessário)
cd ~/Desktop
echo "Diretório Desktop acessado!"

# Verificar se o arquivo JAR já existe
if [ ! -f "sistema-nowl-1.0-jar-with-dependencies.jar" ]; then
    echo "Baixando o arquivo JAR..."
    # Instale o wget se não estiver instalado
    sudo apt install wget -y
    # Baixar o arquivo JAR
    wget https://github.com/SPTECH-Nowl/SistemaJava/raw/main/src/main/java/target/sistema-nowl-1.0-jar-with-dependencies.jar
    echo "Arquivo JAR baixado com sucesso!"
else
    echo "O arquivo JAR já existe. Ignorando o download."
fi

echo "Executando o arquivo JAR..."
# Executar o arquivo JAR
java -jar sistema-nowl-1.0-jar-with-dependencies.jar
chmod +x sistema-nowl-1.0-jar-with-dependencies.jar

echo "Tudo configurado com sucesso, até a próxima!"
