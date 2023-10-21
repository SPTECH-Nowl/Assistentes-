#!/bin/bash
# Define cores para formatação
PURPLE='\033[0;35m'
NC='\033[0m'
VERSAO=17

# Função para exibir mensagem com pausa
show_message() {
    echo -e "${PURPLE}[SPTECH-Nowl]:${NC} $1"
}

show_message "Olá usuário, serei seu assistente para instalação do Java!"
show_message "Verificando se você possui o Java instalado na sua máquina..."

# Verifica se o Java já está instalado
java -version
if [ $? -eq 0 ]; then
    show_message "Você já possui o Java instalado na sua máquina."
    show_message "Vamos atualizar os pacotes..."
    sudo apt update && sudo apt upgrade -y
    clear
    show_message "Pacotes atualizados!"
    # Navega até o diretório Desktop
    cd /home/$USER/Desktop
    show_message "Diretório Desktop acessado!"
    show_message "Agora iremos baixar nosso arquivo JAR..."
    # Baixa o arquivo JAR
    wget https://github.com/SPTECH-Nowl/SistemaJava/Java/main/target/sistema-nowl-1.0-jar-with-dependencies.jar
    chmod 777 sistema-nowl-1.0-jar-with-dependencies.jar
    show_message "Já temos o arquivo! Vamos executá-lo."
    show_message "Pressione Enter para iniciar a execução..."
    # Executa o arquivo JAR
    java -jar sistema-nowl-1.0-jar-with-dependencies.jar
else
    show_message "Não foi encontrada nenhuma versão do Java na sua máquina."
    show_message "Você deseja instalar o Java na sua máquina (S/N)?"
    read inst
    if [ "$inst" == "S" ]; then
        show_message "Ok! Você decidiu instalar o Java na máquina, uhul!"
        show_message "Adicionando o repositório..."
        sleep 7
        sudo add-apt-repository ppa:linuxuprising/java
        clear
        show_message "Atualizando os pacotes... Quase acabando."
        sleep 7
        sudo apt update -y
        clear
        if [ $VERSAO -eq 17 ]; then
            show_message "Preparando para instalar a versão 17 do Java. Lembre-se de confirmar a instalação quando necessário!"
            sudo apt-get install openjdk-17-jdk -y
            clear
            show_message "Java instalado com sucesso!"
            show_message "Vamos atualizar os pacotes..."
            sudo apt update && sudo apt upgrade -y
            clear
            # Navega até o diretório Desktop
            cd /home/$USER/Desktop
            show_message "Diretório Desktop acessado!"
            show_message "Agora iremos baixar nosso arquivo JAR..."
            # Baixa o arquivo JAR
            wget https://github.com/SPTECH-Nowl/SistemaJava/Java/main/target/sistema-nowl-1.0-jar-with-dependencies.jar
            sleep 7
            show_message "Já temos o arquivo! Vamos executá-lo."
            show_message "Pressione Enter para iniciar a execução..."
            # Executa o arquivo JAR
            java -jar sistema-nowl-1.0-jar-with-dependencies.jar
            chmod 777 sistema-nowl-1.0-jar-with-dependencies.jar
        fi
    else
        show_message "Você optou por não instalar o Java por enquanto, até a próxima então!"
    fi
fi
