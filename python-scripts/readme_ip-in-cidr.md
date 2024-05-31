# Filtragem de IPs por CIDR em Arquivos CSV

Este script em Python é projetado para filtrar endereços IP de um arquivo CSV com base em uma lista de prefixos de comprimento de CIDR (Classless Inter-Domain Routing). Ele verifica se cada endereço IP no arquivo CSV está contido em algum dos prefixos de CIDR fornecidos e cria um novo arquivo CSV contendo apenas os endereços IP correspondentes.

## Requisitos

Certifique-se de ter os seguintes requisitos antes de executar o script:

- Python 3 instalado no seu sistema.
- Permissão de escrita no diretório destino.
- Um arquivo CIDR contendo os prefixos de CIDR desejados.
- Um arquivo CSV contendo os endereços IP a serem filtrados.

## Uso

Certifique-se de modificar as variáveis `input_file_path`, `output_file_path` e `ip_field` de acordo com seus requisitos.

Execute o script da seguinte maneira:
```
python3 ./ip-in-cidr.py
```

## Funcionamento

O script funciona da seguinte maneira:

1. Lê os prefixos de CIDR de um arquivo de texto.
2. Lê os endereços IP do arquivo CSV.
3. Filtra os endereços IP com base nos prefixos de CIDR fornecidos.
4. Cria um novo arquivo CSV contendo apenas os endereços IP filtrados.

## Arquivos Necessários

- **Seu arquivo CIDR (`your_cidr_list.txt`):** Um arquivo de texto contendo os prefixos de CIDR desejados, um por linha.
- **Seu arquivo de entrada CSV (`your_input_ips.csv`):** Um arquivo CSV contendo os endereços IP a serem filtrados.

## Atenção

Certifique-se de personalizar o script de acordo com suas necessidades, modificando principalmente o arquivo `output_file_path` para não substituir resultados anteriores.
