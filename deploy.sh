#!/bin/bash

# Verificar se o whiptail está instalado
if ! command -v whiptail &> /dev/null; then
    echo "Instalando whiptail..."
    sudo apt-get install -y whiptail
fi

# Cor de fundo e texto
BG_COLOR="9747FF"
FG_COLOR="white"

# Função para instalar o Docker
install_docker() {
    whiptail --title "Instalação do Docker" --msgbox "Instalando o Docker..." 10 50 --backtitle "Sistema de Monitoramento Magister" --fb --fg
    sudo apt install docker.io
    whiptail --title "Instalação do Docker" --msgbox "Docker instalado com sucesso!" 10 50 --backtitle "Sistema de Monitoramento Magister" --fb --fg

    whiptail --title "Instalação do Docker" --msgbox "Iniciando o serviço do Docker..." 10 50 --backtitle "Sistema de Monitoramento Magister" --fb --fg
    sudo systemctl start docker
    sudo systemctl enable docker

    whiptail --title "Instalação do Docker" --msgbox "Baixando a imagem do MySQL 5.7..." 10 50 --backtitle "Sistema de Monitoramento Magister" --fb --fg
    sudo docker pull mysql:5.7
    whiptail --title "Instalação do Docker" --msgbox "Imagem do MySQL 5.7 baixada com sucesso!" 10 50 --backtitle "Sistema de Monitoramento Magister" --fb --fg

    whiptail --title "Instalação do Docker" --msgbox "Criando e executando o container MySQL..." 10 50 --backtitle "Sistema de Monitoramento Magister" --fb --fg
    sudo docker run -d -p 3306:3306 --name magister -e "MYSQL_ROOT_PASSWORD=aluno" mysql:5.7
    whiptail --title "Instalação do Docker" --msgbox "Container MySQL criado e em execução!" 10 50 --backtitle "Sistema de Monitoramento Magister" --fb --fg

    whiptail --title "Instalação do Docker" --msgbox "Executando o script SQL dentro do container MySQL..." 10 50 --backtitle "Sistema de Monitoramento Magister" --fb --fg
    sleep 15
    sudo docker exec -i magister mysql -u root -paluno < /home/ubuntu/Assistentes-app/script.sql
    whiptail --title "Instalação do Docker" --msgbox "Script SQL executado com sucesso!" 10 50 --backtitle "Sistema de Monitoramento Magister" --fb --fg

    whiptail --title "Instalação do Docker" --msgbox "Dando permissão de execução ao arquivo java.sh..." 10 50 --backtitle "Sistema de Monitoramento Magister" --fb --fg
    chmod +x java.sh
    whiptail --title "Instalação do Docker" --msgbox "Permissão concedida com sucesso!" 10 50 --backtitle "Sistema de Monitoramento Magister" --fb --fg

    whiptail --title "Instalação do Docker" --msgbox "Executando o arquivo java.sh..." 10 50 --backtitle "Sistema de Monitoramento Magister" --fb --fg
    ./java.sh
    whiptail --title "Instalação do Docker" --msgbox "Arquivo java.sh executado com sucesso!" 10 50 --backtitle "Sistema de Monitoramento Magister" --fb --fg
}

# Menu de opções usando whiptail com cores
option=$(whiptail --title "Menu" --menu "Escolha uma opção:" 15 50 5 \
    1 "Instalar Docker e configurar MySQL" \
    2 "Sair" \
    3>&1 1>&2 2>&3)

# Verificando a opção selecionada
case $option in
    1)
        install_docker
        ;;
    2)
        whiptail --title "Saindo" --msgbox "Saindo do script. Nenhuma ação realizada." 10 50 --backtitle "Sistema de Monitoramento Magister" --fb --fg
        ;;
    *)
        whiptail --title "Erro" --msgbox "Opção inválida. Saindo do script." 10 50 --backtitle "Sistema de Monitoramento Magister" --fb --fg
        ;;
esac
