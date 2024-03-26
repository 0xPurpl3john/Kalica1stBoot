#!/bin/bash

main() {
    clear
    echo
    echo '▄▄▄██▀▀▀▄▄▄       ██▀███  ▓█████▄  ██▓ ███▄ ▄███▓'
    echo '  ▒██  ▒████▄    ▓██ ▒ ██▒▒██▀ ██▌▓██▒▓██▒▀█▀ ██▒'
    echo '  ░██  ▒██  ▀█▄  ▓██ ░▄█ ▒░██   █▌▒██▒▓██    ▓██░'
    echo '▓██▄██▓ ░██▄▄▄▄██ ▒██▀▀█▄  ░▓█▄   ▌░██░▒██    ▒██ '
    echo '▓███▒   ▓█   ▓██▒░██▓ ▒██▒░▒████▓ ░██░▒██▒   ░██▒'
    echo '▒▓▒▒░   ▒▒   ▓▒█░░ ▒▓ ░▒▓░ ▒▒▓  ▒ ░▓  ░ ▒░   ░  ░'
    echo '▒ ░▒░    ▒   ▒▒ ░  ░▒ ░ ▒░ ░ ▒  ▒  ▒ ░░  ░      ░'
    echo '░ ░ ░    ░   ▒     ░░   ░  ░ ░  ░  ▒ ░░      ░   '
    echo '░   ░        ░  ░   ░        ░     ░         ░   '
    echo '                           ░                     '
    echo

    while true; do
        echo "Escolha uma opção:"
        echo "1) Atualizar repositórios"
        echo "2) Instalar programas"
        echo "3) Alterar papel de parede"
        echo "4) Desabilitar IPv6"
        echo "5) Configurar terminal"
        echo "6) Configurar o Flameshot"
        echo "7) Tarefas de lista de palavras"
        # echo "8) Adicionar usuário"
        echo "9) Personalizar o prompt"
        echo "10) Reiniciar o sistema"
        echo "11) Sair do programa"

        read -p "Opção selecionada: " opcao

        case $opcao in
            1) update_repositories ;;
            2) install_programs ;;
            3) change_background ;;
            4) disable_ipv6 ;;
            5) configure_terminal ;;
            6) configure_flameshot ;;
            7) wordlist_tasks ;;
            # 8) add_user ;;
            # 9) customize_prompt ;;
            10) restart_system ;;
            11) echo "Saindo do programa."; exit ;;
            *) echo "Opção inválida. Por favor, selecione uma opção válida." ;;
        esac

        echo
        echo
        read -p "Deseja realizar outra operação? (y/n): " continuar
        if [ "$continuar" != "y" ]; then
            break
        fi
    done
    
}

update_repositories() {
    clear
    echo '# Update repositories'
    echo '# Update repositories'
    echo '# Update repositories'

    sudo apt update
    sudo apt upgrade
}

install_programs() {
    clear
    echo '# Instalando aplicativos'
    echo '# Instalando aplicativos'
    echo '# Instalando aplicativos'

    echo ' [+] Instalando flameshot, vim, tilix, tmux e zsh..'
    sudo apt install -y flameshot vim tilix tmux zsh
    echo

    echo ' [+] Instalando Python 3.10.0, Python 3.9.0, Python 2.8.0, Python 2.7.0...'
    for version in 3.10.0 3.9.0 2.8.0 2.7.0; do
        curl -O "https://www.python.org/ftp/python/$version/Python-$version.tgz"
        tar xzf "Python-$version.tgz"
        rm "Python-$version.tgz"
        cd "Python-$version" || continue
        ./configure --enable-optimizations
        make altinstall
        cd ..
        rm -rf "Python-$version"
    done
    echo

    echo ' [+] Instalando outras ferramentas...'
    sudo apt install -y libwine wine wine32 winetricks kali-wallpapers-legacy nuclei dirsearch redis-tools figlet toilet fcrackzip freerdp2-x11 bettercap* jd-gui apktool smali dex2jar jadx dsniff libc6-dev:i386 libssl-dev:i386 seclists isc-dhcp-server proxychains tor mingw-w64 lynx libssl-dev python3-venv oracle-instantclient-sqlplus libreoffice bloodhound.py bloodhound crackmapexec systemd-resolved openvpn openvpn-systemd-resolved
    echo

    echo ' [+] Instalando outras ferramentas via pip...'
    pip install pwntools
    pip3 install kerberos
    echo

    echo ' [+] Instalando paramiko para Python 2.7...'
    pip2.7 install paramiko
    echo

    echo ' [*] Instalando impacket para o python2.7'
    echo
    pip2.7 install impacket==0.10.0

    echo ' [*] Instalando pwntools para o python2.7'
    echo
    pip2 install pwntools

    echo ' [+] Instalando Rustscan...'
    wget https://github.com/RustScan/RustScan/releases/download/2.0.1/rustscan_2.0.1_amd64.deb
    sudo dpkg -i rustscan_2.0.1_amd64.deb
    rm rustscan_2.0.1_amd64.deb
    echo

    echo ' [+] Limpando pacotes desnecessários...'
    sudo apt autoremove -y && sudo apt autoclean
}

wordlist_tasks() {
    clear
    echo '# Configurando WORDLISTS'
    echo '# Configurando WORDLISTS'
    echo '# Configurando WORDLISTS'

    echo ' [+] Descompactando rockyou.txt e convertendo em UTF-8...'
    gunzip /usr/share/wordlists/rockyou.txt.gz
    iconv -f ISO-8859-1 -t UTF-8 /usr/share/wordlists/rockyou.txt > /usr/share/wordlists/rockyou_utf8.txt
    rm /usr/share/wordlists/rockyou.txt
    mv /usr/share/wordlists/rockyou_utf8.txt /usr/share/wordlists/rockyou.txt
    echo

    echo ' [+] Criando wordlist best_common.txt e best_big.txt em /usr/share/wordlists/dirb/...'
    wget https://github.com/d3fudd/Wordlists/releases/download/release/best_common.txt
    wget https://github.com/d3fudd/Wordlists/releases/download/release/best_big.txt
    mv best_common.txt /usr/share/wordlists/dirb/best_common.txt
    mv best_big.txt /usr/share/wordlists/dirb/best_big.txt
    rm best_common.txt best_big.txt
    echo
}

change_background() {
    clear
    echo '# Configurando background'
    echo '# Configurando background'
    echo '# Configurando background'

    # gsettings set org.gnome.desktop.background picture-uri file:///caminho/para/sua/imagem.jpg
    gsettings set org.gnome.desktop.background primary-color '#000000'

}

disable_ipv6() {
    clear
    echo '# Configurando IPV6'
    echo '# Configurando IPV6'
    echo '# Configurando IPV6'
    
    sudo sh -c 'echo "net.ipv6.conf.all.disable_ipv6 = 1" >> /etc/sysctl.conf'
    sudo sh -c 'echo "net.ipv6.conf.default.disable_ipv6 = 1" >> /etc/sysctl.conf'
    sudo sysctl -p
}

configure_terminal() {
    clear
    echo '# Configurando terminal'
    echo '# Configurando terminal'
    echo '# Configurando terminal'

    sudo update-alternatives --config x-terminal-emulator
    # Selecione o número correspondente ao tilix na lista e pressione Enter
}

configure_flameshot() {
    clear
    echo '# Configurando flameshot'
    echo '# Configurando flameshot'
    echo '# Configurando flameshot'

    gsettings set org.gnome.settings-daemon.plugins.media-keys screenshot "['Print']"
    gsettings set org.gnome.settings-daemon.plugins.media-keys custom-keybindings "['/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/']"
    gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/ name 'flameshot'
    gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/ command 'flameshot gui'
    gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/ binding 'Print'
}

# add_user() {
#     clear
#     sudo adduser purpl3john
#     echo 'purpl3john:ChangeME' | sudo chpasswd
#     sudo usermod -aG sudo purpl3john
# }

# customize_prompt() {
#     clear
#     echo '# Customizando prompt'
#     echo '# Customizando prompt'
#     echo '# Customizando prompt'

#     # echo 'PS1="%B%F{magenta}%n%f%b %F{158}%~:%f "' >> ~/.zshrc
#     echo ' [+] Personalizando aliases no ~/.zshrc...'

#     # Categorias
#     echo '# Aliases para navegação' >> ~/.zshrc
#     echo '# ----------------------' >> ~/.zshrc

#     # Navegação
#     echo 'alias ..="cd .."' >> ~/.zshrc
#     echo 'alias ...="cd ../../../"' >> ~/.zshrc
#     echo 'alias ....="cd ../../../../"' >> ~/.zshrc
#     echo 'alias .....="cd ../../../../"' >> ~/.zshrc
#     echo 'alias l.="ls -d .* --color=auto"' >> ~/.zshrc
#     echo 'alias ll="ls -la"' >> ~/.zshrc
#     echo 'alias ls="ls --color=auto"' >> ~/.zshrc

#     echo '' >> ~/.zshrc

#     # Pesquisa
#     echo '# Aliases para pesquisa' >> ~/.zshrc
#     echo '# --------------------' >> ~/.zshrc
#     echo 'alias grep="grep --color=auto"' >> ~/.zshrc
#     echo 'alias egrep="egrep --color=auto"' >> ~/.zshrc
#     echo 'alias fgrep="fgrep --color=auto"' >> ~/.zshrc

#     echo '' >> ~/.zshrc

#     # Outros
#     echo '# Outros aliases' >> ~/.zshrc
#     echo '# --------------' >> ~/.zshrc
#     echo 'alias bc="bc -l"' >> ~/.zshrc
#     echo 'alias mount="mount |column -t"' >> ~/.zshrc
#     echo 'alias h="history"' >> ~/.zshrc
#     echo 'alias j="jobs -l"' >> ~/.zshrc
#     echo 'alias vi="vim"' >> ~/.zshrc
#     echo 'alias svi="sudo vi"' >> ~/.zshrc
#     echo 'alias vis="vim \"+set si\""' >> ~/.zshrc
#     echo 'alias edit="vim"' >> ~/.zshrc
#     echo 'alias me="echo $(ifconfig eth0 | grep \"inet \" | cut -b 9- | cut -d\" \" -f2)"' >> ~/.zshrc

#     echo
# }

restart_system() {
    clear
    read -p "## Reiniciar sistema agora? (y/n): " resposta
    if [ "$resposta" == "y" ]; then
        echo "Reiniciando..."
        sudo reboot
    elif [ "$resposta" == "n" ]; then
        echo "Saindo..."
    else
        echo "Resposta invalida, insira apenas y ou n"
    fi
}

main
