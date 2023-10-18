
# Vá no ubuntu linux - coloque o caminho onde está o arquivo "ass" exemplo:cd /mnt/c/ProgramData/Magister/public/ass

# depois coloque ./install_java.sh

!/bin/bash

PURPLE='0;35'
NC='\033[0m' 
VERSAO=11

echo  "$(tput setaf 10)[SPTECH-Nowl]:$(tput setaf 7) Olá usuário, serei seu assistente para instalação do Java!;"
echo  "$(tput setaf 10)[SPTECH-Nowl]:$(tput setaf 7)  Verificando se você possui o Java instalado na sua máquina pessoal!;"
sleep 2

java -version
if [ $? -eq 0 ]
then
    echo "$(tput setaf 10)[SPTECH-Nowl]:$(tput setaf 7) : O senhor(a) já possui o Java instalado na sua máquina!"

    echo "$(tput setaf 10)[SPTECH-Nowl]:$(tput setaf 7) : Vamos atualizar os pacotes..."
    sudo apt update && sudo apt upgrade -y
    clear
    echo "$(tput setaf 10)[SPTECH-Nowl]:$(tput setaf 7) : Pacotes atualizados!"
	else
		echo "$(tput setaf 10)[SPTECH-Nowl]:$(tput setaf 7)  Não foi encontrado nenhuma versão do Java na sua máquina, mas iremos resolver isso!"
		echo "$(tput setaf 10)[SPTECH-Nowl]:$(tput setaf 7)  Você deseja instalar o Java na sua máquina (S/N)?"
	read inst
	if [ \"$inst\" == \"S\" ]
		then
			echo "$(tput setaf 10)[SPTECH-Nowl]:$(tput setaf 7)  Ok! Você decidiu instalar a máquina, uhul!"
			echo "$(tput setaf 10)[SPTECH-Nowl]:$(tput setaf 7)  Adicionando o repositório!"
			sleep 2
			sudo add-apt-repository ppa:linuxuprising/java
			clear
			echo "$(tput setaf 10)[SPTECH-Nowl]:$(tput setaf 7)  Atualizando os pacotes... Quase acabando."
			sleep 2
			sudo apt update -y
			clear
			if [ $VERSAO -eq 17 ]
				then
					echo "$(tput setaf 10)[SPTECH-Nowl]:$(tput setaf 7) Preparando para instalar a versão 17 do Java. Lembre-se de confirmar a instalação quando necessário!"
					sudo apt-get install openjdk-17-jdk
					clear
					echo "$(tput setaf 10)[SPTECH-Nowl]:$(tput setaf 7) Java instalado com sucesso!"

		            echo "$(tput setaf 10)[SPTECH-Nowl]:$(tput setaf 7) : Vamos atualizar os pacotes..."
		            sudo apt update && sudo apt upgrade -y
		            clear
		            echo "$(tput setaf 10)[SPTECH-Nowl]:$(tput setaf 7) : Pacotes atualizados!"

					
				fi
		else 	
		echo "$(tput setaf 10)[SPTECH-Nowl]:$(tput setaf 7)  Você optou por não instalar o Java por enquanto, até a próxima então!"
	fi
fi

# PURPLE='\033[0;35m'
# NC='\033[0m'
# VERSAO=11

# echo -e "${PURPLE}[SPTECH-Nowl]:${NC} Olá usuário, serei seu assistente para instalação do Java!"
# echo -e "${PURPLE}[SPTECH-Nowl]:${NC} Verificando se você possui o Java instalado na sua máquina pessoal..."
# sleep 2

# if java -version 2>&1 | grep "java version" >/dev/null; then
#     echo -e "${PURPLE}[SPTECH-Nowl]:${NC} Você já possui o Java instalado na sua máquina!"
#     echo -e "${PURPLE}[SPTECH-Nowl]:${NC} Vamos atualizar os pacotes..."
#     sudo apt update && sudo apt upgrade -y
#     clear
#     echo -e "${PURPLE}[SPTECH-Nowl]:${NC} Pacotes atualizados!"
# else
#     echo -e "${PURPLE}[SPTECH-Nowl]:${NC} Não foi encontrado nenhuma versão do Java na sua máquina, mas iremos resolver isso!"
#     echo -e "${PURPLE}[SPTECH-Nowl]:${NC} Você deseja instalar o Java na sua máquina (S/N)?"
#     read -r inst
#     if [ "$inst" == "S" ] || [ "$inst" == "s" ]; then
#         echo -e "${PURPLE}[SPTECH-Nowl]:${NC} Ok! Você decidiu instalar o Java na máquina, uhul!"
#         echo -e "${PURPLE}[SPTECH-Nowl]:${NC} Adicionando o repositório..."
#         sleep 2
#         sudo add-apt-repository ppa:linuxuprising/java
#         clear
#         echo -e "${PURPLE}[SPTECH-Nowl]:${NC} Atualizando os pacotes... Quase acabando."
#         sleep 2
#         sudo apt update -y
#         clear
#         if [ $VERSAO -eq 17 ]; then
#             echo -e "${PURPLE}[SPTECH-Nowl]:${NC} Preparando para instalar a versão 17 do Java. Lembre-se de confirmar a instalação quando necessário!"
#             sudo apt-get install openjdk-17-jdk
#             clear
#             echo -e "${PURPLE}[SPTECH-Nowl]:${NC} Java instalado com sucesso!"
#             echo -e "${PURPLE}[SPTECH-Nowl]:${NC} Vamos atualizar os pacotes..."
#             sudo apt update && sudo apt upgrade -y
#             clear
#             echo -e "${PURPLE}[SPTECH-Nowl]:${NC} Pacotes atualizados!"
#             echo -e "${PURPLE}[SPTECH-Nowl]:${NC} Agora iremos para o diretório Desktop da máquina."
#             cd /home/$USER/Desktop
#             echo -e "${PURPLE}[SPTECH-Nowl]:${NC} Diretório Desktop acessado!"
#             sleep 2
#             echo -e "${PURPLE}[SPTECH-Nowl]:${NC} Agora iremos trazer nosso arquivo JAR..."
#             wget https://raw.githubusercontent.com/SPTECH-Nowl/SistemaJava/main/SPTECH-Nowl/target/SPTECH-Nowl-1.0-SNAPSHOT-jar-with-dependencies.jar
#             sleep 2
#             echo -e "${PURPLE}[SPTECH-Nowl]:${NC} Já temos o arquivo! Vamos executá-lo."
#             sleep 2
#             java -jar SPTECH-Nowl-1.0-SNAPSHOT-jar-with-dependencies.jar
#         fi
#     else
#         echo -e "${PURPLE}[SPTECH-Nowl]:${NC} Você optou por não instalar o Java por enquanto. Até a próxima então!"
#     fi
# fi


# #!/bin/bash
# PURPLE='\033[0;35m'
# NC='\033[0m'

# echo -e "${PURPLE}[SPTECH-Nowl]:${NC} Olá usuário, serei seu assistente para instalação do Java!"
# echo -e "${PURPLE}[SPTECH-Nowl]:${NC} Verificando se você possui o Java instalado na sua máquina pessoal..."
# sleep 2

# # Simular que o Java já está instalado
# if java -version 2>&1 | grep "java version" >/dev/null; then
#     echo -e "${PURPLE}[SPTECH-Nowl]:${NC} Você já possui o Java instalado na sua máquina!"
# else
#     # Simular que o Java não está instalado e o usuário optou por instalá-lo
#     echo -e "${PURPLE}[SPTECH-Nowl]:${NC} Não foi encontrado nenhuma versão do Java na sua máquina, mas iremos resolver isso!"
#     echo -e "${PURPLE}[SPTECH-Nowl]:${NC} Você deseja instalar o Java na sua máquina (S/N)?"
#     read -r inst
#     if [ "$inst" == "S" ] || [ "$inst" == "s" ]; then
#         echo -e "${PURPLE}[SPTECH-Nowl]:${NC} Ok! Você decidiu instalar o Java na máquina, uhul!"
#         # Simular a instalação do Java
#         echo -e "${PURPLE}[SPTECH-Nowl]:${NC} Instalando o Java (simulado)..."
#         sleep 2
#         echo -e "${PURPLE}[SPTECH-Nowl]:${NC} Java instalado com sucesso (simulado)!"
#     else
#         echo -e "${PURPLE}[SPTECH-Nowl]:${NC} Você optou por não instalar o Java por enquanto. Até a próxima então!"
#     fi
# fi



# !/bin/bash

# PURPLE='\033[0;35m'
# NC='\033[0m'
# VERSAO=11

# echo -e "${PURPLE}[SPTECH-Nowl]:${NC} Olá usuário, serei seu assistente para instalação do Java!"
# echo -e "${PURPLE}[SPTECH-Nowl]:${NC} Verificando se você possui o Java instalado na sua máquina pessoal..."
# sleep 2

# if java -version 2>&1 | grep "java version" >/dev/null; then
#     echo -e "${PURPLE}[SPTECH-Nowl]:${NC} Você já possui o Java instalado na sua máquina!"
#     echo -e "${PURPLE}[SPTECH-Nowl]:${NC} Vamos atualizar os pacotes..."
#     sudo apt update && sudo apt upgrade -y
#     clear
#     echo -e "${PURPLE}[SPTECH-Nowl]:${NC} Pacotes atualizados!"
# else
#     echo -e "${PURPLE}[SPTECH-Nowl]:${NC} Não foi encontrado nenhuma versão do Java na sua máquina, mas iremos resolver isso!"
#     echo -e "${PURPLE}[SPTECH-Nowl]:${NC} Você deseja instalar o Java na sua máquina (S/N)?"
#     read -r inst
#     if [ "$inst" == "S" ] || [ "$inst" == "s" ]; then
#         echo -e "${PURPLE}[SPTECH-Nowl]:${NC} Ok! Você decidiu instalar o Java na máquina, uhul!"
#         echo -e "${PURPLE}[SPTECH-Nowl]:${NC} Adicionando o repositório..."
#         sleep 2
#         sudo add-apt-repository ppa:linuxuprising/java
#         clear
#         echo -e "${PURPLE}[SPTECH-Nowl]:${NC} Atualizando os pacotes... Quase acabando."
#         sleep 2
#         sudo apt update -y
#         clear
#         if [ $VERSAO -eq 17 ]; then
#             echo -e "${PURPLE}[SPTECH-Nowl]:${NC} Preparando para instalar a versão 17 do Java. Lembre-se de confirmar a instalação quando necessário!"
#             sudo apt-get install openjdk-17-jdk
#             clear
#             echo -e "${PURPLE}[SPTECH-Nowl]:${NC} Java instalado com sucesso!"
#             echo -e "${PURPLE}[SPTECH-Nowl]:${NC} Vamos atualizar os pacotes..."
#             sudo apt update && sudo apt upgrade -y
#             clear
#             echo -e "${PURPLE}[SPTECH-Nowl]:${NC} Pacotes atualizados!"
#             echo -e "${PURPLE}[SPTECH-Nowl]:${NC} Agora iremos para o diretório Desktop da máquina."
#             cd /home/$USER/Desktop
#             echo -e "${PURPLE}[SPTECH-Nowl]:${NC} Diretório Desktop acessado!"
#             sleep 2
#             echo -e "${PURPLE}[SPTECH-Nowl]:${NC} Agora iremos trazer nosso arquivo JAR..."
#             wget https://raw.githubusercontent.com/SPTECH-Nowl/SistemaJava/main/SPTECH-Nowl/target/SPTECH-Nowl-1.0-SNAPSHOT-jar-with-dependencies.jar
#             sleep 2
#             echo -e "${PURPLE}[SPTECH-Nowl]:${NC} Já temos o arquivo! Vamos executá-lo."
#             sleep 2
#             java -jar SPTECH-Nowl-1.0-SNAPSHOT-jar-with-dependencies.jar
#         fi
#     else
#         echo -e "${PURPLE}[SPTECH-Nowl]:${NC} Você optou por não instalar o Java por enquanto. Até a próxima então!"
#     fi
# fi
