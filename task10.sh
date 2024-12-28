#!/bin/bash

install_aws_cli_ubuntu() {
    echo "Установка AWS CLI на Ubuntu"
    sudo apt update
    sudo apt install unzip
    curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
    unzip awscliv2.zip
    sudo ./aws/install
    echo "AWS CLI установлен."
}



install_aws_cli_redhat() {
    echo "Установка AWS CLI на Red Hat"
    sudo yum install -y awscli
    echo "AWS CLI установлен."
}


install_aws_cli_macos() {
    echo "Установка AWS CLI на macOS"
    curl -O "https://awscli.amazonaws.com/AWSCLIV2.pkg"
    sudo installer -pkg AWSCLIV2.pkg -target /
    echo "AWS CLI установлен."
}


install_aws_cli_windows() {
    echo "Установка AWS CLI на Windows"
    powershell -Command "Invoke-WebRequest -Uri https://awscli.amazonaws.com/AWSCLIV2.msi -OutFile AWSCLIV2.msi"
    powershell -Command "Start-Process msiexec.exe -ArgumentList '/i AWSCLIV2.msi /quiet' -NoNewWindow -Wait"
    echo "AWS CLI установлен."
}

# проверям какая у нас ОС
case "$(uname -s)" in
    Linux)
        if [ -f /etc/os-release ]; then
            . /etc/os-release
            case $ID in
                ubuntu)
                    install_aws_cli_ubuntu
                    ;;
                rhel | centos)
                    install_aws_cli_redhat
                    ;;
                *)
                    echo "Ошибка определения ОС"
                    exit 1
                    ;;
            esac
        else
            echo "Неизвестная версия Linux"
            exit 1
        fi
        ;;
    Darwin)
        install_aws_cli_macos
        ;;
    CYGWIN*|MINGW*|MSYS*)
        install_aws_cli_windows
        ;;
    *)
        echo "Неизвестная операционная система."
        exit 1
        ;;
esac

# настройка AWS CLI
echo "Настраиваем AWS CLI..."
AWS_ACCESS_KEY_ID=''
AWS_SECRET_ACCESS_KEY=''
aws configure set aws_access_key_id "$AWS_ACCESS_KEY_ID" --profile "$AWS_PROFILE"
aws configure set aws_secret_access_key "$AWS_SECRET_ACCESS_KEY" --profile "$AWS_PROFILE"
aws configure set region "eu-north-1" --profile "$AWS_PROFILE"

echo "Установка и настройка AWS CLI завершены."