#!/bin/bash

# bash -c "$(wget -qLO - https://raw.githubusercontent.com/mauriciodelima21/scripts/main/idioma-archlinux.sh)"

# Atualiza a lista de pacotes e instala o pacote de localização glibc
echo "Atualizando a lista de pacotes e instalando o glibc..."
sudo pacman -Syu --noconfirm
sudo pacman -S glibc --needed --noconfirm

# Configura o idioma para Português do Brasil
echo "Configurando o idioma para Português do Brasil..."
sudo sed -i 's/#pt_BR.UTF-8 UTF-8/pt_BR.UTF-8 UTF-8/' /etc/locale.gen
sudo locale-gen

# Configura o arquivo locale.conf
echo "LANG=pt_BR.UTF-8" | sudo tee /etc/locale.conf

# Configura o layout do teclado para ABNT2
echo "Configurando o layout do teclado para ABNT2..."
echo "KEYMAP=br-abnt2" | sudo tee /etc/vconsole.conf

# Configura o timezone para São Paulo
echo "Configurando o timezone para São Paulo..."
sudo ln -sf /usr/share/zoneinfo/America/Sao_Paulo /etc/localtime
sudo hwclock --systohc
timedatectl set-ntp true

# Atualiza a configuração do bash
echo "Atualizando a configuração do bash..."
echo 'export LANG=pt_BR.UTF-8' | sudo tee -a /etc/profile
echo 'export LANGUAGE=pt_BR' | sudo tee -a /etc/profile
echo 'export LC_ALL=pt_BR.UTF-8' | sudo tee -a /etc/profile

# Mensagem de conclusão
echo "Configuração de idioma concluída! Reinicie seu sistema para aplicar as mudanças."
