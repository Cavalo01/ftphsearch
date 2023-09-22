#!/bin/bash

banner=" _____  ______  ____   __ __   _____   ___   ____  ____      __  __ __ 
|     ||      T|    \ |  T  T / ___/  /  _] /    T|    \    /  ]|  T  T
|   __j|      ||  o  )|  l  |(   \_  /  [_ Y  o  ||  D  )  /  / |  l  |
|  l_  l_j  l_j|   _/ |  _  | \__  TY    _]|     ||    /  /  /  |  _  |
|   _]   |  |  |  |   |  |  | /  \ ||   [_ |  _  ||    \ /   \_ |  |  |
|  T     |  |  |  |   |  |  | \    ||     T|  |  ||  .  Y\     ||  |  |
l__j     l__j  l__j   l__j__j  \___jl_____jl__j__jl__j\_j \____jl__j__j
                                                                       
                                                                       "

check_ftp() {
    site="$1"
    prefixes=("ftp." "ftpuser." "ftpupload." "ftpadmin." "www.")
    
    for prefix in "${prefixes[@]}"; do
        if nc -z "$prefix$site" 21 2>/dev/null; then
            echo "Servidor FTP encontrado! Use de maneira ética: $prefix$site"
            return
        fi
    done

    if curl -s --head "http://$site/ftp" | grep "HTTP/1.1 200 OK" 2>/dev/null; then
        echo "Diretório '/ftp' encontrado no site: http://$site/ftp"
        return
    fi

    echo "Nenhum servidor FTP ou diretório '/ftp' encontrado."
}

echo "$banner"
read -p "Informe o URL Alvo: " site
check_ftp "$site"

