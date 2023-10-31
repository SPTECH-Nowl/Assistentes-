#!/bin/bash
# Define colors for formatting
PURPLE='\033[0;35m'
NC='\033[0m'
VERSAO=17

# Function to install Docker and MySQL container
installDockerAndMySQL() {
    echo -e "${PURPLE}[SPTECH-Nowl]:${NC} Olá Cliente, te ajudarei no processo para instalar o Docker e criar o Container com o MySQL 5.7"
    echo -e "${PURPLE}[SPTECH-Nowl]:${NC} Vamos verificar primeiramente se você possui o Docker instalado..."
    sleep 2
    docker -v
    if [ $? -eq 0 ]; then
        echo ": O senhor(a) já tem o Docker instalado!!!"
    else
        echo "Não identificamos nenhuma versão do Docker instalado, porém sem problemas, irei resolver isso agora mesmo!"
        echo "Confirme para nosso sistema se realmente deseja instalar o Docker (S/N)?"
        read inst
        if [ "$inst" == "S" ]; then
            echo "Ok! Você escolheu instalar o Docker ;D"
            echo "Adicionando o repositório!"
            sleep 2
            sudo apt update -y
            clear
            echo "Atualizando! Quase lá."
            sleep 2
            sudo apt install docker.io -y
            sudo systemctl start docker
            sudo systemctl enable docker
            sleep 2
            sudo docker pull mysql:5.7
            sudo docker run -d -p 3306:3306 --name MagisterNowl -e "MYSQL_DATABASE=magister" -e "MYSQL_ROOT_PASSWORD=aluno" mysql:5.7
            sudo docker exec -i MagisterNowl sudo mysql magister bash
            echo "Docker instalado com sucesso e container criado com sucesso!"
            sudo mysql 
            sleep 2
            echo "Agora iremos criar as tabelas no banco de dados"
            sleep 2 
            sudo apt install mysql-server
            mysql
            sudo mysql
             CREATE USER 'aluno'@'localhost' IDENTIFIED BY 'aluno';
              GRANT ALL PRIVILEGES ON * . * TO 'aluno'@'localhost';
              mysql -u aluno -p aluno

              CREATE DATABASE magister;
USE magister;

CREATE TABLE tipoUsuario (
	idTipoUsuario INT PRIMARY KEY AUTO_INCREMENT,
    tipoUsuario VARCHAR(50) NOT NULL
);

CREATE TABLE medida (
	idMedida INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(50),
    unidade VARCHAR(5)
);

CREATE TABLE instituicao (
	idInstituicao INT PRIMARY KEY AUTO_INCREMENT,
	nome VARCHAR(50) NOT NULL,
	sigla VARCHAR(30) NOT NULL,
	codigoHex CHAR(6) NOT NULL
);

CREATE TABLE processo (
	idProcesso INT PRIMARY KEY AUTO_INCREMENT,
	nomeProcesso VARCHAR(100) NOT NULL,
	nomeAplicativo VARCHAR(100) NOT NULL
);

CREATE TABLE tipoHardware (
	idTipoHardware INT PRIMARY KEY AUTO_INCREMENT,
    tipo VARCHAR(100) NOT NULL,
    fkMedida INT, CONSTRAINT tipoHardFkMed FOREIGN KEY (fkMedida)
		REFERENCES medida(idMedida)
);

CREATE TABLE usuario (
	idUsuario INT PRIMARY KEY AUTO_INCREMENT,
	nome VARCHAR(50) NOT NULL,
	email VARCHAR(100) UNIQUE NOT NULL,
	senha VARCHAR(20) NOT NULL,
	fkInstituicao INT, CONSTRAINT usuFkInst FOREIGN KEY (fkInstituicao)
		REFERENCES instituicao(idInstituicao),
	fkTipoUsuario INT, CONSTRAINT usuFkTipoUsu FOREIGN KEY (fkTipoUsuario)
		REFERENCES tipoUsuario(idTipoUsuario)
);

CREATE TABLE hardware (
	idHardware INT PRIMARY KEY AUTO_INCREMENT,
	fabricante VARCHAR(100) NOT NULL,
	modelo VARCHAR(100) NOT NULL,
    capacidade INT NOT NULL,
    especificidade VARCHAR(100),
    fkTipoHardware INT, CONSTRAINT hardFkTipoHard FOREIGN KEY (fkTipoHardware)
		REFERENCES tipoHardware(idTipoHardware)
);

CREATE TABLE maquina (
	idMaquina INT PRIMARY KEY AUTO_INCREMENT,
	nome VARCHAR(50),
	SO VARCHAR(75) NOT NULL,
	emUso TINYINT NOT NULL,
	fkInstituicao INT, CONSTRAINT maqFkInst FOREIGN KEY (fkInstituicao)
		REFERENCES instituicao(idInstituicao)
);
  
CREATE TABLE strike (
	idStrike INT PRIMARY KEY AUTO_INCREMENT,
    dataHora DATETIME NOT NULL,
    validade TINYINT NOT NULL,
    motivo VARCHAR(255) DEFAULT 'Sem motivo definido',
    fkMaquina INT, CONSTRAINT strikFkMaq FOREIGN KEY (fkMaquina)
		REFERENCES maquina(idMaquina)
);
  
  CREATE TABLE componente (
	idComponente INT PRIMARY KEY AUTO_INCREMENT,
	max INT NOT NULL DEFAULT 85,
    fkMaquina INT, CONSTRAINT compFkMaq FOREIGN KEY (fkMaquina)
		REFERENCES maquina(idMaquina),
	fkHardware INT, CONSTRAINT compFkHard FOREIGN KEY (fkHardware)
		REFERENCES hardware(idHardware)
);

CREATE TABLE permissao (
	idPermissao INT PRIMARY KEY AUTO_INCREMENT,
	nome VARCHAR(45) NOT NULL,
    fkUsuario INT, CONSTRAINT permFKUsu FOREIGN KEY (fkUsuario)
		REFERENCES usuario(idUsuario)
);



CREATE TABLE historico (
	idHistorico INT PRIMARY KEY AUTO_INCREMENT,
	dataHora DATETIME NOT NULL,
	consumo DOUBLE NOT NULL,
     qtdJanelasAbertas INT NOT NULL,
	fkMaquina INT, CONSTRAINT histFkMaq FOREIGN KEY (fkMaquina)
		REFERENCES maquina(idMaquina),
	fkHardware INT, CONSTRAINT histFkHard FOREIGN KEY (fkHardware)
		REFERENCES hardware(idHardware),
	fkComponente INT, CONSTRAINT histFkComp FOREIGN KEY (fkComponente)
		REFERENCES componente(idComponente)
);



CREATE TABLE historicoProcesso (
	idHistoricoProcesso INT PRIMARY KEY AUTO_INCREMENT,
    enderecoProcesso VARCHAR(200) NOT NULL,
    fkHistorico INT, CONSTRAINT histProcFkHist FOREIGN KEY (fkHistorico)
		REFERENCES historico(idHistorico),
	fkProcesso INT, CONSTRAINT histProcFkProc FOREIGN KEY (fkProcesso)
		REFERENCES processo(idProcesso)
);

CREATE TABLE permissaoProcesso (
	idPermissaoProcesso INT PRIMARY KEY AUTO_INCREMENT,
	fkProcesso INT NOT NULL,
	fkPermissao INT NOT NULL,
    dataAlocacao DATETIME NOT NULL,
	CONSTRAINT permProcFkProc FOREIGN KEY (fkProcesso) 
		REFERENCES processo (idProcesso),
	CONSTRAINT permProcFkPerm FOREIGN KEY (fkPermissao)
		REFERENCES permissao (idPermissao)
);
            exit
            echo "Tabelas criadas com sucesso!"
            echo "Tudo configurado com sucesso!"
        else
            echo "Você optou por não instalar o Docker por enquanto."
        fi
    fi
}

# Function to install Java and run the Java application
installJavaAndRunApplication() {
    echo -e "${PURPLE}[SPTECH-Nowl]:${NC} Olá usuário, serei seu assistente para instalação do Java!"
    echo -e "${PURPLE}[SPTECH-Nowl]:${NC} Verificando se você possui o Java instalado na sua máquina!"
    sleep 2
    # Verifica se o Java está instalado
    java -version
    if [ $? -eq 0 ]; then
        echo -e "${PURPLE}[SPTECH-Nowl]:${NC} Você já possui o Java instalado na sua máquina!"
        echo -e "${PURPLE}[SPTECH-Nowl]:${NC} Vamos atualizar os pacotes..."
        sudo apt update && sudo apt upgrade -y
        clear
        echo -e "${PURPLE}[SPTECH-Nowl]:${NC} Pacotes atualizados!"
        # Navega até o diretório Desktop
        cd /home/$USER/Desktop
        echo -e "${PURPLE}[SPTECH-Nowl]:${NC} Diretório Desktop acessado!"
        sleep 2
        echo -e "${PURPLE}[SPTECH-Nowl]:${NC} Agora iremos baixar nosso arquivo JAR..."
        # Baixa o arquivo JAR
        git clone https://github.com/SPTECH-Nowl/SistemaWill.git
        sleep 2
        echo -e "${PURPLE}[SPTECH-Nowl]:${NC} Já temos o arquivo! Vamos executá-lo."
        sleep 2
        # Executa o arquivo JAR
         cd SistemaWill/src/main/java/target
              java -jar sistema-will-1.0-jar-with-dependencies.jar
    else
        echo -e "${PURPLE}[SPTECH-Nowl]:${NC} Não foi encontrada nenhuma versão do Java na sua máquina, mas iremos resolver isso!"
        echo -e "${PURPLE}[SPTECH-Nowl]:${NC} Você deseja instalar o Java na sua máquina (S/N)?"
        read inst
        if [ "$inst" == "S" ]; then
            echo -e "${PURPLE}[SPTECH-Nowl]:${NC} Ok! Você decidiu instalar o Java na máquina, uhul!"
            echo -e "${PURPLE}[SPTECH-Nowl]:${NC} Adicionando o repositório!"
            sleep 2
            sudo add-apt-repository ppa:linuxuprising/java
            clear
            echo -e "${PURPLE}[SPTECH-Nowl]:${NC} Atualizando os pacotes... Quase acabando."
            sleep 2
            sudo apt update -y
            clear
            if [ $VERSAO -eq 17 ]; then
                echo -e "${PURPLE}[SPTECH-Nowl]:${NC} Preparando para instalar a versão 17 do Java. Lembre-se de confirmar a instalação quando necessário!"
                sudo apt-get install openjdk-17-jdk
                clear
                echo -e "${PURPLE}[SPTECH-Nowl]:${NC} Java instalado com sucesso!"
                echo -e "${PURPLE}[SPTECH-Nowl]:${NC} Vamos atualizar os pacotes..."
                sudo apt update && sudo apt upgrade -y
                clear
                # Navega até o diretório Desktop
                cd /home/$USER/Desktop
                echo -e "${PURPLE}[SPTECH-Nowl]:${NC} Diretório Desktop acessado!"
                sleep 2
                echo -e "${PURPLE}[SPTECH-Nowl]:${NC} Agora iremos baixar nosso arquivo JAR..."
                # Baixa o arquivo JAR
                git clone https://github.com/SPTECH-Nowl/SistemaWill.git
                sleep 2
                echo -e "${PURPLE}[SPTECH-Nowl]:${NC} Já temos o arquivo! Vamos executá-lo."
                sleep 2
                # Executa o arquivo JAR
                cd SistemaWill/src/main/java/target
              java -jar sistema-will-1.0-jar-with-dependencies.jar
    
            fi
        else
            echo -e "${PURPLE}[SPTECH-Nowl]:${NC} Você optou por não instalar o Java por enquanto, até a próxima então!"
        fi
    fi
}

# Main script
installDockerAndMySQL
installJavaAndRunApplication
