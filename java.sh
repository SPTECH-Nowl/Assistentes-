#!/bin/bash

# URL do arquivo JAR no GitHub
jar_url="https://github.com/SPTECH-Nowl/sistema-will/raw/main/target/sistema-magister-will-1.0-jar-with-dependencies.jar"

# Nome do arquivo JAR após o download
jar_nome="sistema-magister-will-1.0-jar-with-dependencies.jar"

echo "Agora iremos verificar se você já possui o Java instalado, aguarde um instante..."
sleep 5

if ! command -v java &> /dev/null || ! java --version | grep -q "openjdk 17"; then
    echo "Você não possui o Java 17 instalado."
    echo "Confirme se deseja instalar o Java 17 (S/N)?"
    read inst
    if [ "$inst" == "S" ]; then
        echo "Ok! Você escolheu instalar o Java 17."
        echo "Adicionando o repositório..."
        sleep 7
        sudo add-apt-repository ppa:linuxuprising/java -y
        clear
        echo "Atualizando os pacotes... Quase acabando."
        sleep 7
        sudo apt update -y

        # Instalação do Java 17
        echo "Preparando para instalar a versão 17 do Java. Lembre-se de confirmar a instalação quando necessário!"
        sudo apt-get install openjdk-17-jdk -y
        clear
        echo "Java 17 instalado com sucesso!"
        echo "Vamos atualizar os pacotes..."
        sudo apt update && sudo apt upgrade -y
    else
        echo "Você optou por não instalar o Java 17 no momento."
    fi
else
    echo "Você já possui o Java 17 instalado!"
fi

# Verificar se o arquivo JAR já existe
if [ ! -f "$jar_nome" ]; then
    echo "Baixando o arquivo JAR..."
    # Instale o wget se não estiver instalado
    sudo apt install wget -y
    # Baixar o arquivo JAR usando wget
    wget "$jar_url" -O "$jar_nome"

    # Verificar se o download foi bem-sucedido
    if [ $? -eq 0 ]; then
        echo "Download do arquivo JAR concluído com sucesso."
    else
        echo "Erro ao baixar o arquivo JAR."
        exit 1
    fi
else
    echo "Arquivo JAR já existe. Pulando o download."
fi

# Executar o arquivo JAR
java -jar "$jar_nome"

# Verificar se a execução foi bem-sucedida
if [ $? -eq 0 ]; then
    echo "Execução do arquivo JAR bem-sucedida."
else
    echo "Erro ao executar o arquivo JAR."
fi
