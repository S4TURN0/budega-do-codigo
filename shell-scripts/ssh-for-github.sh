#!/bin/bash

# Nome da chave SSH
KEY_NAME="id_rsa_github"
KEY_PATH="$HOME/.ssh/$KEY_NAME"

# Função para verificar se já existe uma chave SSH para GitHub
check_existing_github_key() {
    echo -e "\nVerificando chaves SSH existentes para GitHub..."
    EXISTING_KEY=$(find ~/.ssh -name "*github*" -type f -not -name "*.pub" | head -n 1)
    
    if [ -n "$EXISTING_KEY" ]; then
        echo "Chave SSH existente encontrada: $EXISTING_KEY"
        KEY_PATH="$EXISTING_KEY"
        return 0
    else
        echo "Nenhuma chave SSH existente para GitHub encontrada."
        return 1
    fi
}

# Função para gerar a chave SSH com senha
generate_ssh_key() {
    echo "Gerando uma nova chave SSH..."
    read -sp "Digite a senha para a nova chave SSH: " passphrase
    echo
    ssh-keygen -t rsa -b 4096 -f "$KEY_PATH" -N "$passphrase"
}

# Função para adicionar a chave ao agente SSH
add_ssh_key_to_agent() {
    echo "Adicionando a chave SSH ao agente..."
    eval "$(ssh-agent -s)"
    ssh-add "$KEY_PATH"
}

# Função para configurar o arquivo SSH config
configure_ssh_config() {
    echo "Configurando o arquivo ~/.ssh/config..."
    CONFIG_PATH="$HOME/.ssh/config"
    
    # Criar o arquivo ~/.ssh/config se ele não existir
    if [ ! -f "$CONFIG_PATH" ]; then
        touch "$CONFIG_PATH"
    fi

    if ! grep -q "Host github.com" "$CONFIG_PATH"; then
        {
            echo "Host github.com"
            echo "    HostName github.com"
            echo "    User git"
            echo "    IdentityFile $KEY_PATH"
            echo "    IdentitiesOnly yes"
        } >> "$CONFIG_PATH"
    else
        echo "Configuração para github.com já existe no arquivo ~/.ssh/config"
    fi
}


# Função para testar a conexão SSH
test_ssh_connection() {
    echo -e "\nTestando a conexão SSH com o GitHub..."
    ssh -T git@github.com
}

# Função principal
main() {
    if check_existing_github_key; then
        echo "Usando a chave SSH existente: $KEY_PATH"
    else
        generate_ssh_key
    fi

    add_ssh_key_to_agent
    configure_ssh_config

    if [ ! -f "$KEY_PATH.pub" ]; then
        echo -e "\nCertifique-se de adicionar a chave pública ${KEY_PATH}.pub ao GitHub.\n"
        
        cat "$KEY_PATH.pub"
        
        echo -e "\nAcesse https://github.com/settings/keys e adicione a chave pública.\n"
    else
        echo -e "\nCertifique-se de adicionar a chave pública $KEY_PATH.pub ao GitHub.\n"

        cat "$KEY_PATH.pub"

        echo -e "\nAcesse https://github.com/settings/keys e adicione a chave pública.\n"
    fi

    read -p "Pressione Enter para continuar após adicionar a chave ao GitHub..."

    test_ssh_connection

    echo -e "\nSe a conexão foi bem-sucedida, você pode clonar o repositório usando:"
    echo " $ git clone git@github.com:organization/repositorio.git"
}

# Executar a função principal
main
