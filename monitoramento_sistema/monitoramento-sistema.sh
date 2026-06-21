#!/bin/bash

LOG_DIR="monitoramento_sistema"
mkdir -p $LOG_DIR

function monitorar_logs() {
	grep -E "(fail(ed)?|error|denied|unauthorized)" /var/log/syslog | awk '{print $1, $2, $3, $5, $6, $7}' > $LOG_DIR/monitoramento_logs_sistema.txt
	grep -E "(fail(ed)?|error|denied|unauthorized)" /var/log/auth.log | awk '{print $1, $2, $3, $5, $6, $7}' > $LOG_DIR/monitoramento_logs_auth.txt
}

function monitorar_rede() {
	if ping -c 1 8.8.8.8 > /dev/null; then
		echo "$(date); Conectividade ativa." >> $LOG_DIR/monitoramento_rede.txt 
	else
		echo "$(date): Sem conexão com a internet." >> $LOG_DIR/monitoramento_rede.txt
	fi

	if curl -s --head https://www.alura.com.br/ | grep "HTTP/2 200" > /dev/null; then
		echo "$(date): Conexão com a Alura bem-sucedida." >> $LOG_DIR/monitoramento_rede.txt
	else
		echo "$(date): Conexão com a Alura falhou." >> $LOG_DIR/monitoramento_rede.txt
	fi
}

function monitorar_disco() {
	echo "$(date)" >> $LOG_DIR/monitoramento_disco.txt
	df -h | grep -v "snapfuse" | awk '$5+0 > 70 {print $1 " está com " $5 " de uso."}' >> $LOG_DIR/monitoramento_disco.txt
	echo "Uso de disco no directorios principal:" >> $LOG_DIR/monitoramento_disco.txt
	du -sh /home/natdev >> $LOG_DIR/monitoramento_disco.txt
}

function monitorar_hardware() {
	echo "$(date): Uso de Mémoria RAM:"  >> $LOG_DIR/monitoramento_hardware.txt
	free -h | grep Mem | awk '{print "Total: " $2 ", Usada: " $3 ", Livre: " $4}' >> $LOG_DIR/monitoramento_hardware.txt
	top -bn1 | grep "Cpu(s)" | sed "s/.*, *\([0-9.]*\)%* id.*/\1/" | awk '{print "Uso da CPU: " 100 - $1 "%"}' >> $LOG_DIR/monitoramento_hardware.txt
	echo "Operações de leitura e escrita em disco:" >> $LOG_DIR/monitoramento_hardware.txt
	iostat | grep -E "Device|^sdb|^sdc" | awk '{print $1, $2, $3, $4}' >> $LOG_DIR/monitoramento_hardware.txt
}

function executar_monitoramento() {
	monitorar_logs
	monitorar_rede
	monitorar_disco
	monitorar_hardware
}

executar_monitoramento
