#!/usr/bin/env bash


SCRIPT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" > /dev/null 2>&1 && pwd -P)




remove_flag=""
DETACHED=${DETACHED:-}
while [ $# -gt 0 ]; do
    case "$1" in
        --detached|-d)
            DETACHED=1
            ;;
         --remove|-r)
            remove_flag="1";
            ;;
         --rr|-rr)
            remove_flag="2"
            ;;
        --*)
            echo "Illegal option $1"
            ;;
    esac
    shift $(( $# > 0 ? 1 : 0 ))
done

docker_compose_cmd="docker-compose";
if command -v docker-compose 2>/dev/null 1>/dev/null; then
    :
elif docker compose version; then
    docker_compose_cmd="docker compose"
else
    echo "docker compose Not found,please install..."
    exit 1;
fi


is_detached() {
    if [ -z "$DETACHED" ]; then
        return 1
    else
        return 0
    fi
}

init_containers() {

docker network inspect iceberg_net &>/dev/null || docker network create --subnet 172.222.0.0/16 --gateway 172.222.0.1 --driver bridge iceberg_net

}

if [ "$remove_flag" = "1" ]; then
    echo "will remove all containers, ${docker_compose_cmd} down"
    ${docker_compose_cmd} down
elif [ "$remove_flag" = "2" ]; then
    echo "will remove all containers and data, ${docker_compose_cmd} down --volumes"


    ${docker_compose_cmd} down --volumes
else


  init_containers

  if is_detached; then
      ${docker_compose_cmd} up -d
  else
      ${docker_compose_cmd} up
  fi

fi




