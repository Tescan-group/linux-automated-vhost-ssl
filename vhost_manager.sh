#!/bin/bash

# Virtual Host Management Script with Language Support and Certbot Integration

# Language support (EN, TR, pt, DE)
declare -A translations
translations=(
    ["en"]="Virtual Host Management Script"
    ["tr"]="Sanal Host Yönetim Scripti"
    ["pt"]="Script de Gerenciamento de Host Virtual"
    ["de"]="Virtuelle Host-Management-Skript"

    ["choose_language_en"]="Choose a language [en/tr/pt/de]: "
    ["choose_language_tr"]="Dil seçin [en/tr/pt/de]: "
    ["choose_language_pt"]="Escolha um idioma [en/tr/pt/de]: "
    ["choose_language_de"]="Wählen Sie eine Sprache [en/tr/pt/de]: "

    ["unsupported_os_en"]="Unsupported OS"
    ["unsupported_os_tr"]="Desteklenmeyen İşletim Sistemi"
    ["unsupported_os_pt"]="Sistema Operacional não suportado"
    ["unsupported_os_de"]="Nicht unterstütztes Betriebssystem"

    ["unsupported_web_server_en"]="Neither Nginx nor Apache is installed."
    ["unsupported_web_server_tr"]="Nginx veya Apache kurulu değil."
    ["unsupported_web_server_pt"]="Nem o Nginx nem o Apache está instalado."
    ["unsupported_web_server_de"]="Weder Nginx noch Apache ist installiert."

    ["enter_domain_en"]="Enter domain name: "
    ["enter_domain_tr"]="Alan adı girin: "
    ["enter_domain_pt"]="Digite o nome de domínio: "
    ["enter_domain_de"]="Geben Sie den Domainnamen ein: "

    ["enter_doc_root_en"]="Enter document root (default: /var/www/%s): "
    ["enter_doc_root_tr"]="Belge kökünü girin (varsayılan: /var/www/%s): "
    ["enter_doc_root_pt"]="Digite o diretório raiz do documento (padrão: /var/www/%s): "
    ["enter_doc_root_de"]="Geben Sie das Dokument-Root ein (Standard: /var/www/%s): "

    ["virtual_host_created_en"]="Virtual host for %s has been created."
    ["virtual_host_created_tr"]="%s için sanal host oluşturuldu."
    ["virtual_host_created_pt"]="Host virtual para %s foi criado."
    ["virtual_host_created_de"]="Virtueller Host für %s wurde erstellt."

    ["virtual_host_deleted_en"]="Virtual host for %s has been deleted."
    ["virtual_host_deleted_tr"]="%s için sanal host silindi."
    ["virtual_host_deleted_pt"]="Host virtual para %s foi excluído."
    ["virtual_host_deleted_de"]="Virtueller Host für %s wurde gelöscht."

    ["virtual_host_updated_en"]="Virtual host for %s has been updated."
    ["virtual_host_updated_tr"]="%s için sanal host güncellendi."
    ["virtual_host_updated_pt"]="Host virtual para %s foi atualizado."
    ["virtual_host_updated_de"]="Virtueller Host für %s wurde aktualisiert."

    ["do_ssl_en"]="Do you want to install SSL using Certbot for %s? (y/n): "
    ["do_ssl_tr"]="%s için Certbot kullanarak SSL kurmak istiyor musunuz? (y/n): "
    ["do_ssl_pt"]="Você deseja instalar o SSL usando o Certbot para %s? (y/n): "
    ["do_ssl_de"]="Möchten Sie SSL mit Certbot für %s installieren? (y/n): "
    ["installing_certbot_en"]="Certbot is not installed. Installing Certbot..."
    ["installing_certbot_tr"]="Certbot kurulmamış. Certbot yükleniyor..."
    ["installing_certbot_pt"]="Certbot não está instalado. Instalando Certbot..."
    ["installing_certbot_de"]="Certbot ist nicht installiert. Certbot wird installiert..."
    ["installing_py3_en"]="Python3 is not installed. Installing Python3..."
    ["installing_py3_tr"]="Python3 kurulmamış. Python3 yükleniyor..."
    ["installing_certbot_pt"]="Certbot não está instalado. Instalando Certbot..."
    ["installing_certbot_de"]="Certbot ist nicht installiert. Certbot wird installiert..."
    ["main_menu_install_ssl_en"]="Install SSL for a domain"
    ["main_menu_install_ssl_tr"]="Bir alan adı için SSL kur"
    ["main_menu_install_ssl_pt"]="Instalar SSL para um domínio"
    ["main_menu_install_ssl_de"]="SSL für eine Domain installieren"
    ["enter_domain_ssl_en"]="Please enter the domain for SSL setup:"
    ["enter_domain_ssl_tr"]="SSL kurulumu için lütfen domain girin:"
    ["enter_domain_ssl_pt"]="Por favor, insira o domínio para a configuração do SSL:"
    ["enter_domain_ssl_de"]="Bitte geben Sie die Domain für die SSL-Einrichtung ein:"


    
    ["list_nginx_vhost_en"]="Listing Nginx virtual hosts..."
    ["list_nginx_vhost_tr"]="Nginx sanal ortam listeleniyor..."
    ["list_nginx_vhost_pt"]="Listando hosts virtuais do Nginx..."
    ["list_nginx_vhost_de"]="Nginx virtuelle Hosts werden aufgelistet..."
    ["list_apache_vhost_en"]="Listing Apache virtual hosts..."
    ["list_apache_vhost_tr"]="Apache sanal ev sahipleri listeleniyor..."
    ["list_apache_vhost_pt"]="Listando hosts virtuais do Apache..."
    ["list_apache_vhost_de"]="Apache virtuelle Hosts werden aufgelistet..."
    ["choose_web_server_en"]="Which web server would you like to use?"
    ["choose_web_server_tr"]="Hangi web sunucusunu kullanmak istersiniz?"
    ["choose_web_server_pt"]="Qual servidor web você gostaria de usar?"
    ["choose_web_server_de"]="Welchen Webserver möchten Sie verwenden?"
    
    ["menu_title_en"]="Virtual Host Management Menu"
    ["menu_title_tr"]="Sanal Host Yönetim Menüsü"
    ["menu_title_pt"]="Menu de Gerenciamento de Host Virtual"
    ["menu_title_de"]="Menü für das Management virtueller Hosts"

    ["add_vhost_en"]="Add Virtual Host"
    ["add_vhost_tr"]="Sanal Host Ekle"
    ["add_vhost_pt"]="Adicionar Host Virtual"
    ["add_vhost_de"]="Virtuellen Host hinzufügen"

    ["delete_vhost_en"]="Delete Virtual Host"
    ["delete_vhost_tr"]="Sanal Host Sil"
    ["delete_vhost_pt"]="Excluir Host Virtual"
    ["delete_vhost_de"]="Virtuellen Host löschen"

    ["edit_vhost_en"]="Edit Virtual Host"
    ["edit_vhost_tr"]="Sanal Host Düzenle"
    ["edit_vhost_pt"]="Editar Host Virtual"
    ["edit_vhost_de"]="Virtuellen Host bearbeiten"

    ["exit_en"]="Exit"
    ["exit_tr"]="Çıkış"
    ["exit_pt"]="Sair"
    ["exit_de"]="Beenden"

    ["choose_option_en"]="Choose an option [1-4]: "
    ["choose_option_tr"]="Bir seçenek seçin [1-4]: "
    ["choose_option_pt"]="Escolha uma opção [1-4]: "
    ["choose_option_de"]="Wählen Sie eine Option [1-4]: "

    ["invalid_option_en"]="Invalid option."
    ["invalid_option_tr"]="Geçersiz seçenek."
    ["invalid_option_pt"]="Opção inválida."
    ["invalid_option_de"]="Ungültige Option."

    ["installing_ssl_en"]="Installing SSL for %s..."
    ["installing_ssl_tr"]="%s için SSL kuruluyor..."
    ["installing_ssl_pt"]="Instalando SSL para %s..."
    ["installing_ssl_de"]="SSL für %s wird installiert..."

    ["choose_web_server_en"]="Choose web server to install [1: Nginx, 2: Apache]: "
    ["choose_web_server_tr"]="Yüklenecek web sunucusunu seçin [1: Nginx, 2: Apache]: "
    ["choose_web_server_pt"]="Escolha o servidor web para instalar [1: Nginx, 2: Apache]: "
    ["choose_web_server_de"]="Wählen Sie den Webserver zum Installieren aus [1: Nginx, 2: Apache]: "

    ["install_web_server_en"]="Do you want to install %s? (y/n): "
    ["install_web_server_tr"]="%s kurulumu yapmak istiyor musunuz? (y/n): "
    ["install_web_server_pt"]="Deseja instalar o %s? (y/n): "
    ["install_web_server_de"]="Möchten Sie %s installieren? (y/n): "

    ["installing_en"]="Installing %s..."
    ["installing_tr"]="%s kuruluyor..."
    ["installing_pt"]="Instalando %s..."
    ["installing_de"]="Installiere %s..."

    ["select_vhost_delete_en"]="Select a virtual host to delete:"
    ["confirm_delete_en"]="Are you sure you want to delete the virtual host"
    ["files_to_delete_en"]="The following files will be deleted:"
    ["confirm_prompt_en"]="Type 'y' to confirm or any other key to cancel:"
    ["delete_aborted_en"]="Deletion aborted."
    
    ["select_vhost_delete_tr"]="Silmek için bir sanal ev sahibi seçin:"
    ["confirm_delete_tr"]="Sanal ev sahibi silmek istediğinizden emin misiniz"
    ["files_to_delete_tr"]="Aşağıdaki dosyalar silinecek:"
    ["confirm_prompt_tr"]="Onaylamak için 'y' yazın veya iptal etmek için başka bir tuşa basın:"
    ["delete_aborted_tr"]="Silme işlemi iptal edildi."
    
    ["select_vhost_delete_pt"]="Selecione um host virtual para excluir:"
    ["confirm_delete_pt"]="Tem certeza de que deseja excluir o host virtual"
    ["files_to_delete_pt"]="Os seguintes arquivos serão excluídos:"
    ["confirm_prompt_pt"]="Digite 'y' para confirmar ou qualquer outra tecla para cancelar:"
    ["delete_aborted_pt"]="Exclusão cancelada."
    
    ["select_vhost_delete_de"]="Wählen Sie einen virtuellen Host zum Löschen:"
    ["confirm_delete_de"]="Sind Sie sicher, dass Sie den virtuellen Host löschen möchten"
    ["files_to_delete_de"]="Die folgenden Dateien werden gelöscht:"
    ["confirm_prompt_de"]="Geben Sie 'y' ein, um zu bestätigen, oder eine andere Taste, um abzubrechen:"
    ["delete_aborted_de"]="Löschung abgebrochen."

)

# Set default language to English
language="en"

# Function to set the language based on user input
set_language() {
    echo "${translations["choose_language_$language"]}"
    read -r selected_language
    case $selected_language in
        "en"|"tr"|"pt"|"de")
            language=$selected_language
            ;;
        *)
            echo "Unsupported language. Defaulting to English."
            ;;
    esac
}

# Function to check if the user has sudo privileges
check_sudo() {
    if ! sudo -v > /dev/null 2>&1; then
        echo "Sudo privileges are required to run this script."
        exit 1
    fi
}

# Detect the OS
detect_os() {
    if [ -f /etc/os-release ]; then
        . /etc/os-release
        os=$ID
    else
        echo "${translations["unsupported_os_$language"]}"
        exit 1
    fi
}

# Function to install Nginx
install_nginx() {
    echo "$(printf "${translations["installing_$language"]}" "Nginx")"
    if [[ "$os" == "centos" ]]; then
        sudo yum install -y nginx
        sudo systemctl start nginx
        sudo systemctl enable nginx
    elif [[ "$os" == "ubuntu" || "$os" == "debian" ]]; then
        sudo apt update
        sudo apt install -y nginx
        sudo systemctl start nginx
        sudo systemctl enable nginx
    fi
}

# Function to install Apache
install_apache() {
    echo "$(printf "${translations["installing_$language"]}" "Apache")"
    if [[ "$os" == "centos" ]]; then
        sudo yum install -y httpd
        sudo systemctl start httpd
        sudo systemctl enable httpd
    elif [[ "$os" == "ubuntu" || "$os" == "debian" ]]; then
        sudo apt update
        sudo apt install -y apache2
        sudo systemctl start apache2
        sudo systemctl enable apache2
    fi
}

# Function to detect or install the web server
detect_web_server() {

    # Check if both web servers are installed
    if command -v nginx > /dev/null && command -v apache2 > /dev/null; then
        echo "${translations["choose_web_server_$language"]}"
        echo "1) Nginx"
        echo "2) Apache"
        read -r choice
        case $choice in
            1)
                web_server="nginx"
                ;;
            2)
                web_server="apache"
                ;;
            *)
                echo "${translations["invalid_option_$language"]}"
                exit 1
                ;;
        esac
    elif command -v nginx > /dev/null; then
        web_server="nginx"
    elif command -v apache2 > /dev/null || command -v httpd > /dev/null; then
        web_server="apache"
    else
        echo "${translations["choose_web_server_$language"]}"
        read -r choice
        case $choice in
            1)
                web_server="nginx"
                ;;
            2)
                web_server="apache"
                ;;
            *)
                echo "${translations["invalid_option_$language"]}"
                exit 1
                ;;
        esac
        
        echo "$(printf "${translations["install_web_server_$language"]}" "$web_server")"
        read -r install_choice
        if [[ $install_choice == "y" ]]; then
            if [ "$web_server" == "nginx" ]; then
                install_nginx
            else
                install_apache
            fi
        else
            echo "${translations["unsupported_web_server_$language"]}"
            exit 1
        fi
    fi
}

# Function to check and install Certbot with Python method
install_certbot() {
    if ! command -v certbot > /dev/null; then
        echo "${translations["installing_certbot_$language"]}"
        if [[ "$os" == "centos" ]]; then
            sudo yum install -y epel-release
            sudo yum install -y certbot python3-certbot-nginx python3-certbot-apache
        elif [[ "$os" == "ubuntu" || "$os" == "debian" ]]; then
            sudo apt update
            sudo apt install -y certbot python3-certbot-nginx python3-certbot-apache
        fi
    fi

    
}

# Function to setup SSL with Certbot and check for existing certificates
setup_ssl() {
    # Check if the domain is provided, prompt if not
    if [ -z "$domain" ]; then
        echo "${translations["enter_domain_ssl_$language"]}"
        read -r domain
    fi

    echo "$(printf "${translations["do_ssl_$language"]}" "$domain")"
    read -r ssl_choice
    if [[ $ssl_choice == "y" ]]; then
        if sudo certbot certificates | grep -q "Domains:.*$domain"; then
            echo "SSL certificate already exists for $domain."
        else
            # Proper Certbot command depending on web server
            if [ "$web_server" == "nginx" ]; then
                install_certbot
                sudo certbot --nginx -d "$domain" -d "www.$domain"
            elif [ "$web_server" == "apache" ]; then
                install_certbot
                sudo certbot --apache -d "$domain" -d "www.$domain"
            fi
            echo "$(printf "${translations["installing_ssl_$language"]}" "$domain")"
        fi

        # Set up auto-renewal cron job
        echo "0 0,12 * * * root /opt/certbot/bin/python -c 'import random; import time; time.sleep(random.random() * 3600)' && sudo certbot renew -q" | sudo tee -a /etc/crontab > /dev/null
    fi
}

# Function to add a virtual host
add_virtual_host() {
    echo "${translations["enter_domain_$language"]}"
    read -r domain

    # Set default document root
    default_doc_root="/var/www/$domain"
    echo "$(printf "${translations["enter_doc_root_$language"]}" "$domain")"
    read -r doc_root
    doc_root=${doc_root:-$default_doc_root}

    # Create document root directory if it doesn't exist
    sudo mkdir -p "$doc_root"
    sudo chown -R "$USER":"$USER" "$doc_root"
    sudo chmod -R 755 "$doc_root"

    if [ "$web_server" == "nginx" ]; then
        # Create Nginx virtual host
        sudo tee /etc/nginx/sites-available/$domain > /dev/null <<EOL
server {
    listen 80;
    server_name $domain www.$domain;
    root $doc_root;

    index index.html index.htm index.nginx-debian.html;

    location / {
        try_files \$uri \$uri/ =404;
    }
}
EOL
        sudo ln -s /etc/nginx/sites-available/$domain /etc/nginx/sites-enabled/
        sudo nginx -t
        sudo systemctl restart nginx
    elif [ "$web_server" == "apache" ]; then
        # Create Apache virtual host
        sudo tee /etc/apache2/sites-available/$domain.conf > /dev/null <<EOL
<VirtualHost *:80>
    ServerAdmin webmaster@$domain
    ServerName $domain
    ServerAlias www.$domain
    DocumentRoot $doc_root
    ErrorLog \${APACHE_LOG_DIR}/error.log
    CustomLog \${APACHE_LOG_DIR}/access.log combined
</VirtualHost>
EOL
        sudo a2ensite $domain.conf
        sudo systemctl restart apache2
    fi

    echo "$(printf "${translations["virtual_host_created_$language"]}" "$domain")"

    # Optionally install SSL using Certbot
    setup_ssl
}

# Function to delete a virtual host
delete_virtual_host() {
    # List available virtual hosts
    list_virtual_hosts

    # Prompt user to select from listed vhosts
    echo "${translations["select_vhost_delete_$language"]}"
    read -r domain

    # Check if the selected virtual host exists
    if [ -z "$domain" ] || [[ ! " $available_vhosts " =~ " $domain " ]]; then
        echo "${translations["vhost_not_exist_$language"]}"
        return
    fi

    # Confirm deletion
    echo "${translations["confirm_delete_$language"]} $domain?"
    echo "${translations["files_to_delete_$language"]}"
    
    if [ "$web_server" == "nginx" ]; then
        echo "/etc/nginx/sites-available/$domain"
        echo "/etc/nginx/sites-enabled/$domain"
    elif [ "$web_server" == "apache" ]; then
        echo "/etc/apache2/sites-available/$domain.conf"
    fi

    echo "${translations["confirm_prompt_$language"]}"
    read -r confirm_choice

    if [[ $confirm_choice != "y" ]]; then
        echo "${translations["delete_aborted_$language"]}"
        return
    fi

    # Proceed with deletion
    if [ "$web_server" == "nginx" ]; then
        sudo rm /etc/nginx/sites-available/$domain
        sudo rm /etc/nginx/sites-enabled/$domain
        sudo nginx -t
        sudo systemctl restart nginx
    elif [ "$web_server" == "apache" ]; then
        sudo a2dissite "$domain.conf"
        sudo rm /etc/apache2/sites-available/$domain.conf
        sudo apachectl configtest
        sudo systemctl restart apache2
    fi

    echo "$(printf "${translations["virtual_host_deleted_$language"]}" "$domain")"
}


# Function to list existing virtual hosts
list_virtual_hosts() {
    if [ "$web_server" == "nginx" ]; then
        echo "${translations["list_nginx_vhost_$language"]}"
        available_vhosts=$(ls /etc/nginx/sites-available)
    elif [ "$web_server" == "apache" ]; then
        echo "${translations["list_apache_vhost_$language"]}"
        available_vhosts=$(ls /etc/apache2/sites-available | grep '.conf')
    fi
    echo "$available_vhosts"
}

# Function to edit a virtual host
edit_virtual_host() {
    # List available vhosts
    list_virtual_hosts

    # Prompt user to select from listed vhosts
    echo "${translations["select_vhost_edit_$language"]}"
    read -r domain

    if [ -z "$domain" ] || [[ ! " $available_vhosts " =~ " $domain " ]]; then
        echo "${translations["vhost_not_exist_$language"]}"
        return
    fi

    # Edit the selected virtual host
    if [ "$web_server" == "nginx" ]; then
        sudo nano /etc/nginx/sites-available/$domain
        sudo nginx -t
        sudo systemctl restart nginx
    elif [ "$web_server" == "apache" ]; then
        # Ensure to strip '.conf' extension from Apache vhost name if user inputs it
        domain=$(echo "$domain" | sed 's/\.conf$//')
        sudo nano /etc/apache2/sites-available/$domain.conf
        sudo apachectl configtest
        sudo systemctl restart apache2
    fi

    echo "$(printf "${translations["virtual_host_updated_$language"]}" "$domain")"
}

# Main menu
main_menu() {
    while true; do
        echo "${translations["menu_title_$language"]}"
        echo "1) ${translations["add_vhost_$language"]}"
        echo "2) ${translations["delete_vhost_$language"]}"
        echo "3) ${translations["edit_vhost_$language"]}"
        echo "4) ${translations["main_menu_install_ssl_$language"]}"
        echo "5) ${translations["exit_$language"]}"
        echo "${translations["choose_option_$language"]}"

        read -r choice
        case $choice in
            1) add_virtual_host ;;
            2) delete_virtual_host ;;
            3) edit_virtual_host ;;
            4) setup_ssl ;;
            5) exit 0 ;;
            *) echo "${translations["invalid_option_$language"]}" ;;
        esac
    done
}

# Run script
set_language
check_sudo
detect_os
detect_web_server
main_menu
