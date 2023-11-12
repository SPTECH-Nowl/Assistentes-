#!/bin/bash

# Mensagem informativa sobre a verificação do Java
echo "Verificando se o Java está instalado..."
sleep 5

if ! command -v java &> /dev/null; then
    echo "Java não encontrado no sistema."
    echo "Deseja instalar o Java (S/N)?"
    read inst
    if [ "$inst" == "S" ]; then
        echo "Preparando para instalar o Java..."
        echo "Adicionando o repositório..."
        sleep 7
        sudo add-apt-repository ppa:linuxuprising/java -y
        clear
        echo "Atualizando os pacotes..."
        sleep 7
        sudo apt update -y

        # Instalação do Java
        echo "Escolha a versão do Java que deseja instalar (8/11/17):"
        read VERSAO
        if [ $VERSAO -eq 17 ]; then
            echo "Preparando para instalar a versão 17 do Java. Lembre-se de confirmar a instalação quando necessário!"
            sudo apt-get install openjdk-17-jdk -y
            clear
            echo "Java instalado com sucesso!"
            echo "Atualizando os pacotes..."
            sudo apt update && sudo apt upgrade -y
        else
            echo "Versão do Java não reconhecida ou não selecionada. Saindo..."
            exit 1
        fi
    else
        echo "Você optou por não instalar o Java neste momento."
    fi
else
    echo "Java já está instalado!"
fi

# Verificar se o arquivo JAR já existe
if [ ! -f "sistema-nowl-1.0-jar-with-dependencies.jar" ]; then
    echo "Baixando o arquivo JAR..."
    # Instale o wget se não estiver instalado
    sudo apt install wget -y
    # Baixar o arquivo JAR
    wget https://github.com/SPTECH-Nowl/SistemaJava/raw/main/src/main/java/target/sistema-nowl-1.0-jar-with-dependencies.jar
    echo "Arquivo JAR baixado com sucesso!"
else
    echo "O arquivo JAR já existe. Nenhuma ação necessária."
fi