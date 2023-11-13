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


# Verificar se o arquivo JAR já existe
if [ ! -f "sistema-magister-1.0-jar-with-dependencies.jar" ]; then
    echo "Baixando o arquivo JAR..."
    # Instale o wget se não estiver instalado
    sudo apt install wget -y
    # Baixar o arquivo JAR
    wget https://github.com/SPTECH-Nowl/SistemaTeste1/target/sistema-magister-1.0-jar-with-dependencies.jar
  java -jar sistema-magister-1.0-jar-with-dependencies.jar
echo "Arquivo JAR baixado com sucesso!"
else
    echo "O arquivo JAR já existe. Ignorando o download."
fi
