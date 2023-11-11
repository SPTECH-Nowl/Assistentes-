#!/bin/bash

# Definir as cores
PURPLE='\033[0;35m'
NC='\033[0m' # Para resetar a cor
VERSAO=17

# Função para exibir mensagens com formatação
show_message() {
    echo -e "${PURPLE}[SPTECH-Nowl]:${NC} $1"
}

show_message "Olá Cliente, te ajudarei no processo para instalar o Docker e criar o Container com o MySQL 8.0"
show_message "Vamos verificar primeiramente se você possui o Docker instalado...;"
sleep 10

# Verifica se o Docker já está instalado
if ! command -v docker &> /dev/null; then
    show_message "Você ainda não possui o Docker instalado."
    echo "Confirme para nosso sistema se realmente deseja instalar o Docker (S/N)?"
    read inst
    if [ "$inst" == "S" ]; then
        show_message "Ok! Você escolheu instalar o Docker ;D"
        show_message "Adicionando o repositório!"
        sleep 10
        # Instalação do Docker
        sudo apt update -y
        sudo apt install docker.io -y
        sudo systemctl start docker
        sudo systemctl enable docker
        show_message "Docker instalado com sucesso!"
        show_message "Agora iremos instalar o container com nosso banco de dados"
        sleep 7

        # Iniciando o container
        if [ -z "$(docker ps -q -f name=ContainerBancoDados)" ]; then
            show_message "Iniciando o container MySQL 8.0..."
            sudo docker pull mysql:8.0
            sudo docker run -d -p 3306:3306 --name ContainerBancoDados -e "MYSQL_DATABASE=magister" -e "MYSQL_ROOT_PASSWORD=aluno" mysql:8.0
            show_message "Container MySQL 8.0 criado com sucesso!"

            show_message "Estamos quase acabando, só precisamos criar nossas tabelas do banco de dados!"
            sleep 2
			sudo docker cp /home/ubuntu/Assistentes-app/script.sql magister:/script.sql

            # Certifique-se de que o arquivo "script.sql" existe no diretório atual
            if [ -e "script.sql" ]; then
                sudo docker exec -it ContainerBancoDados bash
				mysql -uroot -paluno magister < /script.sql
                show_message "Tabelas criadas com sucesso!"
            else
                show_message "Arquivo 'script.sql' não encontrado. As tabelas não puderam ser criadas."
            fi
        else
            show_message "Você optou por não instalar o Docker no momento, até a próxima!"
        fi
    else
        show_message "Você optou por não instalar o Docker no momento, até a próxima!"
    fi
else
    show_message "Você já possui o Docker instalado!"
fi

show_message "Agora iremos verificar se você já possui o Java instalado, aguarde um instante..."
sleep 5

if ! command -v java &> /dev/null; then
    show_message "Você ainda não possui o Java instalado."
    echo "Confirme se deseja instalar o Java (S/N)?"
    read inst
    if [ "$inst" == "S" ]; then
        show_message "Ok! Você escolheu instalar o Java."
        show_message "Adicionando o repositório..."
        sleep 7
        sudo add-apt-repository ppa:linuxuprising/java -y
        clear
        show_message "Atualizando os pacotes... Quase acabando."
        sleep 7
        sudo apt update -y

        # Instalação do Java
        if [ $VERSAO -eq 17 ]; then
            show_message "Preparando para instalar a versão 17 do Java. Lembre-se de confirmar a instalação quando necessário!"
            sudo apt-get install openjdk-17-jdk -y
            clear
            show_message "Java instalado com sucesso!"
            show_message "Vamos atualizar os pacotes..."
            sudo apt update && sudo apt upgrade -y
        fi
    else
        show_message "Você optou por não instalar o Java no momento."
    fi
else
    show_message "Você já possui o Java instalado!"
fi

# Navegar para o diretório Desktop (ajuste o caminho conforme necessário)
cd ~/Desktop
show_message "Diretório Desktop acessado!"

show_message "Baixando o arquivo JAR..."
# Instale o wget se não estiver instalado
sudo apt install wget -y
# Baixar o arquivo JAR
wget https://github.com/SPTECH-Nowl/SistemaJava/raw/main/src/main/java/target/sistema-nowl-1.0-jar-with-dependencies.jar
show_message "Arquivo JAR baixado com sucesso!"

show_message "Executando o arquivo JAR..."
# Executar o arquivo JAR
java -jar sistema-nowl-1.0-jar-with-dependencies.jar
chmod +x sistema-nowl-1.0-jar-with-dependencies.jar

show_message "Tudo configurado com sucesso, até a próxima!"
