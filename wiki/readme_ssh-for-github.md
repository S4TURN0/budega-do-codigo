# Script de Configuração de Chave SSH para GitHub

Este script em Shell Script é projetado para configurar uma chave SSH para o GitHub, verificar se uma chave já existe, gerar uma nova chave se necessário, adicionar a chave ao agente SSH, configurar o arquivo SSH config e testar a conexão SSH com o GitHub.

## Requisitos

Certifique-se de ter os seguintes requisitos antes de executar o script:

- Um sistema operacional Linux com o interpretador de shell Bash instalado.
- A ferramenta `ssh-keygen` disponível no seu sistema.
- A ferramenta `git` disponível no seu sistema.
- Permissões de escrita no diretório `~/.ssh/` fornecido.
- Uma conta no GitHub.

## Uso

Atribua permissão de execução ao arquivo:
```
chmod +x ./script_ssh_github.sh
```

Execute o script da seguinte maneira:

```
./script_ssh_github.sh
```

## Funcionamento

O script funciona da seguinte maneira:

1. Verifica se já existe uma chave SSH para o GitHub no diretório `~/.ssh`.
2. Se nenhuma chave for encontrada, o script gera uma nova chave SSH com uma senha fornecida pelo usuário.
3. Adiciona a chave SSH gerada ou existente ao agente SSH para facilitar autenticações futuras.
4. Configura o arquivo `~/.ssh/config` para que o SSH utilize automaticamente a chave ao conectar-se ao GitHub.
5. Exibe a chave pública gerada e fornece instruções para adicionar esta chave nas configurações de Chaves SSH do GitHub em [GitHub SSH Settings](https://github.com/settings/keys).
6. Após configurar a chave, o script testa automaticamente a conexão SSH com o GitHub para garantir que a configuração esteja correta.

## Atenção

Alguns pontos importantes a serem observados ao utilizar este script:

- Verifique se você possui permissões adequadas para criar e modificar arquivos no diretório `~/.ssh`.
- Ao gerar uma nova chave SSH, lembre-se da senha fornecida. Esta senha será necessária para autenticar o uso da chave.
- Copie a chave pública exibida no terminal e adicione-a nas [Configurações de Chaves SSH do GitHub](https://github.com/settings/keys).
- Mantenha suas chaves SSH seguras e não compartilhe sua chave privada com outras pessoas.
