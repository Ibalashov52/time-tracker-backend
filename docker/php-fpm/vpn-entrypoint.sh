#!/bin/sh
set -e

echo "vpn-client ip: $(dig +short vpn-client)"
ip route delete default # удалить стандартный роут, чтобы добавить новый
ip route add default via $(dig +short vpn-client) # сделать адрес vpn контейнера шлюзом по умолчанию для отправки трафика (обычно он 192.168.80.2)

# first arg is `-f` or `--some-option`
if [ "${1#-}" != "$1" ]; then
        set -- php-fpm "$@"
fi

exec "$@"
