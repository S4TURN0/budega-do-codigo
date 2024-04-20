#!/bin/bash

# Verificar se o argumento foi fornecido
if [ $# -ne 1 ]; then
    echo "Uso: $0 <diretório_ponto_de_montagem>"
    exit 1
fi

# Extrair o diretório do ponto de montagem fornecido
mount_point="$1"

# Verificar se o diretório existe
if [ ! -d "$mount_point" ]; then
    echo "Diretório de ponto de montagem não encontrado: $mount_point"
    exit 1
fi

# Identificar o dispositivo externo associado ao ponto de montagem
device=$(df -P "$mount_point" | awk 'NR==2 {print $1}')

# Verificar se o dispositivo foi identificado
if [ -z "$device" ]; then
    echo "Não foi possível identificar o dispositivo associado ao ponto de montagem: $mount_point"
    exit 1
fi

echo "Dispositivo externo identificado: $device"

# Verificar o espaço disponível no dispositivo
available_space=$(df -BG "$device" | awk 'NR==2 {print $4}' | tr -d 'G')

echo "Espaço disponível no dispositivo: ${available_space}GB"

# Definir o tamanho máximo de arquivo como 4GB
max_file_size_gb=4

# Calcular o número máximo de arquivos que podem ser alocados
max_files=$((available_space / max_file_size_gb))

echo "Número máximo de arquivos que podem ser alocados: $max_files"

# Criar arquivos até que o espaço disponível seja ocupado
i=1
while [ $i -le $max_files ]; do
    dd if=/dev/zero of="$mount_point/file_$i.dat" bs=1G count=$max_file_size_gb status=progress
    echo "Arquivo $i criado"
    i=$((i + 1))
done

echo "Processo concluído"
