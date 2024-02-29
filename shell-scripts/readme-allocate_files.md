# Alocação de Arquivos em dispositivos

Este script em Shell é projetado para alocar arquivos em um dispositivo externo até que o espaço disponível seja ocupado. Ele pode ser útil para testes de desempenho de armazenamento, criação de grandes conjuntos de dados de teste, entre outros casos de uso.

## Requisitos

Certifique-se de ter os seguintes requisitos antes de executar o script:

- Um sistema operacional Linux com o interpretador de shell Bash instalado.
- Permissões de escrita no diretório de ponto de montagem fornecido.

## Uso

Atribua permissão de execução ao arquivo:
```
sudo chmod +x ./allocate_files.sh
```

Execute o script da seguinte maneira:

```
./allocate_files.sh <diretório_ponto_de_montagem>
```


Substitua `<diretório_ponto_de_montagem>` pelo caminho do diretório de ponto de montagem onde deseja alocar os arquivos.

## Funcionamento

O script funciona da seguinte maneira:

1. Verifica se o argumento do diretório de ponto de montagem foi fornecido.
2. Identifica o dispositivo externo associado ao ponto de montagem.
3. Verifica o espaço disponível no dispositivo.
4. Calcula o número máximo de arquivos que podem ser alocados com base no espaço disponível e no tamanho máximo de arquivo definido (4GB por padrão).
5. Cria arquivos no diretório de ponto de montagem até que o espaço disponível seja ocupado.

## Atenção

- Este script irá ocupar todo o espaço disponível no dispositivo. Certifique-se de usá-lo com cautela e em um ambiente de teste adequado.
- Sempre faça backup dos dados importantes antes de executar este script.
